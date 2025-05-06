# imports
from starlette.responses import RedirectResponse, FileResponse, JSONResponse, HTMLResponse
from fastapi.templating import Jinja2Templates
from starlette.exceptions import HTTPException
from fastapi.staticfiles import StaticFiles
from sqlalchemy.orm import sessionmaker, Session, declarative_base
from starlette.requests import Request
from sqlalchemy import create_engine, Column, String, Integer, Boolean, Text, func, text, inspect, or_
from typing import Optional, List, Dict, Any
from dotenv import load_dotenv
from fastapi import FastAPI, Query, Depends
from contextlib import asynccontextmanager
import uvicorn
import random
import os
import logging
import sys
import datetime

# --- Logging-System einrichten ---
class ColoredFormatter(logging.Formatter):
    COLORS = {
        'DEBUG': '\033[94m',  # Blau
        'INFO': '\033[92m',   # Grün
        'WARNING': '\033[93m', # Gelb
        'ERROR': '\033[91m',  # Rot
        'CRITICAL': '\033[91m\033[1m', # Fett-Rot
        'RESET': '\033[0m'    # Reset
    }
    def format(self, record):
        log_message = super().format(record)
        return f"{self.COLORS.get(record.levelname, self.COLORS['RESET'])}{log_message}{self.COLORS['RESET']}"

# Logger konfigurieren
logger = logging.getLogger("minecraft_api")
logger.setLevel(logging.DEBUG)

# Verhindere doppelte Handler-Registrierung bei Reload
if not logger.hasHandlers():
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setLevel(logging.DEBUG)
    console_format = ColoredFormatter('%(asctime)s [%(levelname)s] %(message)s',
                                     datefmt='%H:%M:%S')
    console_handler.setFormatter(console_format)
    current_date_for_filename = datetime.datetime.now().strftime("%Y-%m-%d")
    if not os.path.exists("logs"):
        os.makedirs("logs")
    file_handler = logging.FileHandler(f"logs/minecraft_api_{current_date_for_filename}.log", encoding='utf-8')
    file_handler.setLevel(logging.INFO)
    file_format = logging.Formatter('%(asctime)s [%(levelname)s] %(message)s',
                                   datefmt='%Y-%m-%d %H:%M:%S')
    file_handler.setFormatter(file_format)
    logger.addHandler(console_handler)
    logger.addHandler(file_handler)

# Umgebungsvariablen aus .env-Datei laden
logger.info("Lade Umgebungsvariablen aus .env-Datei...")
load_dotenv()

# Datenbank-Konfigurationswerte aus Umgebungsvariablen
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_NAME = os.getenv("DB_NAME")

logger.info(f"Datenbank-Konfiguration: Host={DB_HOST}, Datenbank={DB_NAME}, Benutzer={DB_USER}")

# MySQL-Datenbank-Verbindung konfigurieren
DATABASE_URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# --- SQLAlchemy Item Model ---
class Item(Base):
    __tablename__ = "items"
    number = Column(String(10), index=True)
    id = Column(String(50), primary_key=True, index=True) # Minecraft ID (z.B. "minecraft:dirt")
    name = Column(String(50), index=True)
    category = Column(String(20), index=True)
    description = Column(Text, nullable=True)
    stack_size = Column(Integer, default=64)
    craftable = Column(Boolean, default=False)

# Globaler Startzeitpunkt für Uptime-Berechnung
app_start_time = datetime.datetime.now()

# --- Datenbank-Check-Funktionen ---
def check_database_connection():
    """Prüft, ob die Datenbank erreichbar ist"""
    try:
        logger.info("Prüfe Datenbankverbindung...")
        with engine.connect() as conn:
            result = conn.execute(text("SELECT 1"))
            if result.scalar() == 1:
                logger.info("Datenbankverbindung erfolgreich hergestellt")
                return True
            else:
                logger.error("Datenbankverbindung fehlgeschlagen: Unerwartete Antwort")
                return False
    except Exception as e:
        logger.error(f"Datenbankverbindung fehlgeschlagen: {e}")
        return False

def check_table_schema():
    """Prüft, ob die Tabellenschemata den Erwartungen entsprechen"""
    try:
        logger.info("Prüfe Datenbankschema...")
        inspector = inspect(engine)
        if 'items' not in inspector.get_table_names():
            logger.error("Schema-Fehler: Tabelle 'items' nicht gefunden!")
            return False
        columns = {c['name'] for c in inspector.get_columns('items')}
        required_columns = {'number', 'id', 'name', 'category',
                           'description', 'stack_size', 'craftable'}
        missing_columns = required_columns - columns
        if missing_columns:
            logger.error(f"Schema-Fehler: Fehlende Spalten in 'items': {missing_columns}")
            return False
        logger.info(f"✓ Tabellenschema korrekt: {len(columns)} Spalten gefunden")
        return True
    except Exception as e:
        logger.error(f"Fehler beim Überprüfen des Schemas: {e}")
        return False

def count_items():
    """Zählt die Anzahl der Items in der Datenbank"""
    try:
        with SessionLocal() as session:
            count = session.query(func.count(Item.id)).scalar()
            logger.info(f"✓ Datenbankstatus: {count} Items in der Datenbank gefunden")
            return count
    except Exception as e:
        logger.error(f"Fehler beim Zählen der Items: {e}")
        return -1

# --- Hilfsfunktion zum Konvertieren von SQLAlchemy-Objekten in Dicts ---
def item_to_dict(item: Item) -> Dict[str, Any]:
    css_friendly_id = item.id.replace("minecraft:", "").replace("_", "-")
    
    return {
        "number": item.number,
        "id": item.id,
        "item_id": css_friendly_id,
        "name": item.name,
        "category": item.category,
        "description": item.description,
        "stack_size": item.stack_size,
        "craftable": item.craftable
    }

# --- Lifespan Event Handler ---
@asynccontextmanager
async def lifespan(app: FastAPI):
    """Verwaltet Startup- und Shutdown-Events der Anwendung."""
    global app_start_time
    app_start_time = datetime.datetime.now() # Setze Startzeit hier
    logger.info("====== WEBSITE WIRD GESTARTET ======")
    logger.info(f"Zeitstempel: {app_start_time.strftime('%Y-%m-%d %H:%M:%S')}")
    logger.info(f"Modus: READ-ONLY (keine Datenänderungen erlaubt)")
    db_connection_ok = check_database_connection()
    schema_ok = check_table_schema() if db_connection_ok else False

    if not db_connection_ok or not schema_ok:
        logger.warning("Die Anwendung läuft, aber es gibt Probleme mit der Datenbank!")
    else:
        logger.info("Alle Datenbank-Checks erfolgreich abgeschlossen.")
    yield
    logger.info("====== WEBSITE WIRD BEENDET ======")


# --- FastAPI-Anwendung initialisieren ---
app = FastAPI(
    lifespan=lifespan,
    docs_url=None,
    redoc_url=None,
    openapi_url=None
)


# --- Abhängigkeit für Datenbank-Session ---
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# --- Hilfsfunktionen (AJAX-Check, Redirect) ---
def is_ajax_request(request: Request) -> bool:
    """Prüft, ob es sich um eine AJAX-Anfrage handelt"""
    return "application/json" in request.headers.get("accept", "")

def create_redirect_response(request: Request, url: str, status_code: int = 302):
    """Erstellt eine Weiterleitungsantwort basierend auf dem Anfrage-Typ"""
    if is_ajax_request(request):
        return JSONResponse({"redirect": True, "url": url}, status_code=status_code)
    return RedirectResponse(url=url, status_code=status_code)

# --- Template-Engine und Statische Dateien ---
templates = Jinja2Templates(directory="templates")
app.mount("/assets", StaticFiles(directory="static/assets"), name="static")
logger.debug("Template-Engine und statische Dateien initialisiert")

# --- Fehlerbehandlung ---
@app.exception_handler(HTTPException)
async def custom_exception_handler(request: Request, exc):
    """Behandelt HTTP-Ausnahmen und gibt formatierte Fehlermeldungen zurück"""
    logger.warning(f"HTTP-Fehler: {exc.status_code} - {exc.detail}")
    context = {"request": request, "error_code": exc.status_code, "error_message": str(exc.detail)}
    if is_ajax_request(request):
        return JSONResponse({"error": {"code": exc.status_code, "message": str(exc.detail)}}, status_code=exc.status_code)
    return templates.TemplateResponse("error.html", context, status_code=exc.status_code)

# --- Routen ---
@app.get("/")
async def home(request: Request):
    """Startseite der Anwendung"""
    logger.debug(f"Route aufgerufen: / (Home)")
    template = templates.get_template("home.html")
    content = template.render({"request": request})
    if is_ajax_request(request):
        return JSONResponse({"html": content})
    return templates.TemplateResponse("home.html", {"request": request})

@app.get("/search")
async def search_page(request: Request):
    """Suchseite der Anwendung"""
    logger.debug(f"Route aufgerufen: /search")
    template = templates.get_template("search.html")
    content = template.render({"request": request})
    if is_ajax_request(request):
        return JSONResponse({"html": content})
    return templates.TemplateResponse("search.html", {"request": request})

@app.get("/api/search", response_model=List[Dict[str, Any]])
async def search_items(
        q: Optional[str] = Query(None, description="Search term"),
        category: Optional[str] = Query(None, description="Item category"),
        db: Session = Depends(get_db)
):
    """API-Endpunkt für die Itemsuche (fragt Datenbank ab)"""
    logger.debug(f"API-Aufruf: /api/search mit q={q}, category={category}")
    query = db.query(Item)
    if q:
        query = query.filter(Item.name.ilike(f"%{q}%"))
    if category and category != "" and category != "all":
        query = query.filter(Item.category == category)

    results = query.all()
    logger.debug(f"Suchergebnisse: {len(results)} Items gefunden")
    items_dict = [item_to_dict(item) for item in results]
    
    for item in items_dict:
        if ":" not in item["id"]:
            item["id"] = f"minecraft:{item['id']}"
        # Stelle sicher, dass item_id vorhanden ist (für das Template)
        if "item_id" not in item or not item["item_id"]:
            item["item_id"] = item["id"].replace("minecraft:", "")
    
    return items_dict

@app.get("/item/{item_identifier}", response_class=HTMLResponse)
async def item_detail(request: Request, item_identifier: str, db: Session = Depends(get_db)):
    """Zeigt die Detailseite für ein einzelnes Item an."""
    logger.debug(f"Anfrage für Item-Detailseite: {item_identifier}")

    item = db.query(Item).filter(or_(Item.id == item_identifier, Item.id == f"minecraft:{item_identifier}")).first()

    if not item and item_identifier.isdigit():
        item = db.query(Item).filter(Item.number == int(item_identifier)).first()

    if not item:
        logger.warning(f"Item nicht gefunden: {item_identifier}")
        return templates.TemplateResponse("error.html", {"request": request, "error_message": "Item not found"}, status_code=404)


    item_dict = item_to_dict(item)
    logger.debug(f"Item gefunden: {item_dict['name']} (ID: {item_dict['id']}, item_id: {item_dict['item_id']})")

    item_id = item_dict.get('item_id', '')
    
    if not item_id and 'id' in item_dict:
        full_item_id = item_dict['id']
        if ":" in full_item_id:
            item_id = full_item_id.split(':')[-1]
        else:
            item_id = full_item_id
        item_id = item_id.replace("_", "-")

    logger.debug(f"Verwende item_id für Templates: {item_id}")

    return templates.TemplateResponse("item.html", {
        "request": request,
        "item": item_dict,
        "item_id": item_id
    })

@app.get("/random")
async def random_item(request: Request, db: Session = Depends(get_db)):
    """Weiterleitung zu einem zufälligen Item (fragt Datenbank ab)"""
    logger.debug(f"Route aufgerufen: /random")
    item_count = db.query(func.count(Item.id)).scalar()

    if not item_count or item_count == 0:
         logger.warning("Keine Items für Zufallsauswahl verfügbar")
         raise HTTPException(status_code=404, detail="Keine Items verfügbar für Zufallsauswahl")
    random_offset = random.randint(0, item_count - 1)
    random_item_obj = db.query(Item).offset(random_offset).first()

    if not random_item_obj:
        logger.warning("Zufälliges Item konnte nicht ausgewählt werden")
        raise HTTPException(status_code=404, detail="Konnte kein zufälliges Item auswählen")
    logger.debug(f"Zufälliges Item ausgewählt: {random_item_obj.name} ({random_item_obj.id})")
    return create_redirect_response(request, f"/item/{random_item_obj.id}")

# --- Statische Routen und Weiterleitungen ---
@app.get("/data")
async def show_data(request: Request, db: Session = Depends(get_db)):
    items = db.query(Item).all()
    items_data = [item_to_dict(item) for item in items] # items_data ist eine Liste
    return templates.TemplateResponse("raw.html", {"request": request, "data": items_data})


@app.get("/options")
async def options(request: Request):
    """Optionen-Seite (noch nicht implementiert)"""
    logger.debug(f"Route aufgerufen: /options (nicht implementiert)")
    raise HTTPException(status_code=501, detail="Not implemented yet")

@app.get("/quit")
async def leave(request: Request):
    """Verlassen der Anwendung"""
    logger.debug(f"Route aufgerufen: /quit (Weiterleitung)")
    return create_redirect_response(request, "https://www.stupidedia.org/stupi/Taube")

@app.get("/robots.txt")
async def robots():
    """Liefert die robots.txt-Datei"""
    logger.debug(f"Route aufgerufen: /robots.txt")
    return FileResponse("static/robots.txt")

@app.get("/manifest.json")
async def manifest_file():
    """Liefert die manifest.json-Datei"""
    logger.debug(f"Route aufgerufen: /manifest.json")
    return FileResponse("static/manifest.json")

@app.get("/sitemap.xml")
async def sitemap_file():
    """Liefert die sitemap.xml-Datei"""
    logger.debug(f"Route aufgerufen: /sitemap.xml")
    return FileResponse("static/sitemap.xml")

@app.get("/impressum")
async def impressum(request: Request):
    """Impressum-Weiterleitung"""
    logger.debug(f"Route aufgerufen: /impressum (Weiterleitung)")
    return create_redirect_response(request, "https://error44.dev/impressum")

@app.get("/datenschutz")
async def datenschutz(request: Request):
    """Datenschutz-Weiterleitung"""
    logger.debug(f"Route aufgerufen: /datenschutz (Weiterleitung)")
    return create_redirect_response(request, "https://error44.dev/datenschutz")

# --- Hauptausführung ---
if __name__ == '__main__':
    logger.info("Starte Webserver minecraft.error44.dev")
    uvicorn.run(app, log_config=None)
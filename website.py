# imports
from starlette.responses import RedirectResponse, FileResponse, JSONResponse
from fastapi.templating import Jinja2Templates
from starlette.exceptions import HTTPException
from fastapi.staticfiles import StaticFiles
from sqlalchemy.orm import sessionmaker, Session, declarative_base
from starlette.requests import Request
from sqlalchemy import create_engine, Column, String, Integer, Boolean, func, text, inspect, or_, Float, ForeignKey
from typing import Dict, Any
from dotenv import load_dotenv
from fastapi import FastAPI, Depends
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
        'INFO': '\033[92m',  # Grün
        'WARNING': '\033[93m',  # Gelb
        'ERROR': '\033[91m',  # Rot
        'CRITICAL': '\033[91m\033[1m',  # Fett-Rot
        'RESET': '\033[0m'  # Reset
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


# Definition der Datenbank-Modelle
class Item(Base):
    __tablename__ = "items"

    numID = Column(String(6), primary_key=True)
    name = Column(String(20))
    textID = Column(String(50))
    stackSize = Column(Integer)
    craftability = Column(Boolean)
    renewability = Column(Boolean)
    description = Column(String(128))
    rarityID = Column(String(2), ForeignKey("rarity.rarityID"))

    def to_dict(self):
        return {
            "number": self.numID,
            "name": self.name,
            "id": self.textID,
            "stack_size": self.stackSize,
            "craftable": self.craftability,
            "renewability": self.renewability,
            "description": self.description,
            "rarity_id": self.rarityID,
            "category": "items"
        }



class Block(Base):
    __tablename__ = "blocks"

    numID = Column(String(5), primary_key=True)
    name = Column(String(25))
    textID = Column(String(32))
    stackSize = Column(Integer)
    craftability = Column(Boolean)
    # tool-Spalte entfernen oder als kompatibel markieren
    hardness = Column(Float)
    blastResistance = Column(Float)
    transparency = Column(Boolean)
    flammability = Column(Boolean)
    fuel = Column(Boolean)
    renewability = Column(Boolean)
    description = Column(String(128))
    rarityID = Column(String(2))

    def to_dict(self):
        return {
            "number": self.numID,
            "name": self.name,
            "id": self.textID,
            "stack_size": self.stackSize,
            "craftable": self.craftability,
            # "tool": self.tool,  # Entfernen oder anpassen
            "hardness": self.hardness,
            "blast_resistance": self.blastResistance,
            "transparent": self.transparency,
            "flammability": self.flammability,
            "fuel": self.fuel,
            "renewability": self.renewability,
            "description": self.description,
            "rarity_id": self.rarityID,
            "category": "blocks"
        }

class Tool(Base):
    __tablename__ = "tools"

    numID = Column(String(3), primary_key=True)
    name = Column(String(15))
    textID = Column(String(32))
    stackSize = Column(Integer)
    craftability = Column(Boolean)
    damage = Column(Float)
    durability = Column(Float)
    enchantability = Column(Boolean)
    fuel = Column(Boolean)
    description = Column(String(128))
    rarityID = Column(String(2), ForeignKey("rarity.rarityID"))

    def to_dict(self):
        return {
            "number": self.numID,
            "name": self.name,
            "id": self.textID,
            "stack_size": self.stackSize,
            "craftable": self.craftability,
            "damage": self.damage,
            "durability": self.durability,
            "enchantability": self.enchantability,
            "fuel": self.fuel,
            "description": self.description,
            "rarity_id": self.rarityID,
            "category": "tools"
        }


class Armor(Base):
    __tablename__ = "armor"

    numID = Column(Integer, primary_key=True)
    name = Column(String(20))
    textID = Column(String(32))
    stackSize = Column(Integer)
    craftability = Column(Boolean)
    armorPoints = Column(Float)
    durability = Column(Float)
    enchantability = Column(Boolean)
    description = Column(String(128))
    rarityID = Column(String(2), ForeignKey("rarity.rarityID"))

    def to_dict(self):
        return {
            "number": str(self.numID),
            "name": self.name,
            "id": self.textID,
            "stack_size": self.stackSize,
            "craftable": self.craftability,
            "armor_points": self.armorPoints,
            "durability": self.durability,
            "enchantability": self.enchantability,
            "description": self.description,
            "rarity_id": self.rarityID,
            "category": "armor"
        }


class Consumable(Base):
    __tablename__ = "consumables"

    numID = Column(Integer, primary_key=True)
    name = Column(String(15))
    textID = Column(String(32))
    stackSize = Column(Integer)
    craftability = Column(Boolean)
    animalFodder = Column(Boolean)
    description = Column(String(128))
    rarityID = Column(String(2), ForeignKey("rarity.rarityID"))

    def to_dict(self):
        return {
            "number": str(self.numID),
            "name": self.name,
            "id": self.textID,
            "stack_size": self.stackSize,
            "craftable": self.craftability,
            "animal_fodder": self.animalFodder,
            "description": self.description,
            "rarity_id": self.rarityID,
            "category": "consumables"
        }


class Potion(Base):
    __tablename__ = "potions"

    numID = Column(String(9), primary_key=True)
    name = Column(String(22))
    duration = Column(String(5))
    textID = Column(String(32))
    stackSize = Column(Integer)
    craftability = Column(Boolean)
    levelTwo = Column(Boolean)
    throwability = Column(Boolean)
    description = Column(String(128))
    rarityID = Column(String(2), ForeignKey("rarity.rarityID"))

    def to_dict(self):
        return {
            "number": self.numID,
            "name": self.name,
            "id": self.textID,
            "stack_size": self.stackSize,
            "craftable": self.craftability,
            "duration": self.duration,
            "level_two": self.levelTwo,
            "throwability": self.throwability,
            "description": self.description,
            "rarity_id": self.rarityID,
            "category": "potions"
        }


class Other(Base):
    __tablename__ = "other"

    numID = Column(Integer, primary_key=True)
    name = Column(String(16))
    textID = Column(String(32))
    stackSize = Column(Integer)
    craftability = Column(Boolean)
    description = Column(String(128))
    rarityID = Column(String(2), ForeignKey("rarity.rarityID"))

    def to_dict(self):
        return {
            "number": str(self.numID),
            "name": self.name,
            "id": self.textID,
            "stack_size": self.stackSize,
            "craftable": self.craftability,
            "description": self.description,
            "rarity_id": self.rarityID,
            "category": "other"
        }


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

        # Überprüfe, ob alle erforderlichen Tabellen existieren
        required_tables = ["items", "blocks", "tools", "armor", "consumables", "potions", "other", "rarity"]
        existing_tables = inspector.get_table_names()

        missing_tables = [table for table in required_tables if table not in existing_tables]

        if missing_tables:
            logger.error(f"Schema-Fehler: Folgende Tabellen fehlen: {', '.join(missing_tables)}")
            return False

        logger.info(f"✓ Alle erforderlichen Tabellen gefunden: {len(required_tables)} Tabellen")
        return True
    except Exception as e:
        logger.error(f"Fehler beim Überprüfen des Schemas: {e}")
        return False


def count_items():
    """Zählt die Anzahl der Items in allen Datenbanktabellen"""
    try:
        with SessionLocal() as session:
            item_count = session.query(func.count(Item.numID)).scalar() or 0
            block_count = session.query(func.count(Block.numID)).scalar() or 0
            tool_count = session.query(func.count(Tool.numID)).scalar() or 0
            armor_count = session.query(func.count(Armor.numID)).scalar() or 0
            consumable_count = session.query(func.count(Consumable.numID)).scalar() or 0
            potion_count = session.query(func.count(Potion.numID)).scalar() or 0
            other_count = session.query(func.count(Other.numID)).scalar() or 0

            total_count = item_count + block_count + tool_count + armor_count + consumable_count + potion_count + other_count

            logger.info(f"✓ Datenbankstatus: {total_count} Einträge gefunden:")
            logger.info(f"  - Items: {item_count}")
            logger.info(f"  - Blöcke: {block_count}")
            logger.info(f"  - Werkzeuge: {tool_count}")
            logger.info(f"  - Rüstungen: {armor_count}")
            logger.info(f"  - Verbrauchsmaterial: {consumable_count}")
            logger.info(f"  - Tränke: {potion_count}")
            logger.info(f"  - Sonstiges: {other_count}")

            return total_count
    except Exception as e:
        logger.error(f"Fehler beim Zählen der Einträge: {e}")
        return -1


# --- Hilfsfunktion zum Konvertieren von SQLAlchemy-Objekten in Dicts ---
def item_to_dict(item) -> Dict[str, Any]:
    """Konvertiert ein Item-Objekt in ein Dictionary"""
    if hasattr(item, "to_dict"):
        return item.to_dict()

    # Fallback für dynamische Query-Ergebnisse
    result = {}

    # ID und Name-Felder
    if hasattr(item, 'numID'):
        result["number"] = item.numID
    elif hasattr(item, 'number'):
        result["number"] = item.number

    if hasattr(item, 'textID'):
        result["id"] = item.textID
    elif hasattr(item, 'id'):
        result["id"] = item.id

    if hasattr(item, 'name'):
        result["name"] = item.name

    # Item-ID für CSS
    if hasattr(item, 'textID') and item.textID:
        css_friendly_id = item.textID.replace("minecraft:", "").replace("_", "-")
    elif hasattr(item, 'id') and item.id:
        css_friendly_id = item.id.replace("minecraft:", "").replace("_", "-")
    else:
        css_friendly_id = ""

    result["item_id"] = css_friendly_id

    # Kategorie
    if hasattr(item, 'category'):
        result["category"] = item.category

    # Gemeinsame Attribute
    for attr in ['description', 'rarityID', 'rarity_id']:
        if hasattr(item, attr):
            result[attr] = getattr(item, attr)

    # Mengen- und Herstellungsattribute
    if hasattr(item, 'stackSize'):
        result["stack_size"] = item.stackSize
    elif hasattr(item, 'stack_size'):
        result["stack_size"] = item.stack_size

    if hasattr(item, 'craftability'):
        result["craftable"] = item.craftability
    elif hasattr(item, 'craftable'):
        result["craftable"] = item.craftable

    # Spezielle Attribute je nach Kategorie
    special_attrs = {
        'blocks': ['hardness', 'blast_resistance', 'transparent', 'flammability', 'tool'],
        'tools': ['damage', 'durability', 'enchantability', 'fuel'],
        'armor': ['armor_points', 'durability', 'enchantability'],
        'consumables': ['animal_fodder'],
        'potions': ['duration', 'level_two', 'throwability'],
        'items': ['renewability'],
    }

    # Alle möglichen speziellen Attribute hinzufügen, wenn vorhanden
    for attrs in special_attrs.values():
        for attr in attrs:
            snake_case = attr
            camel_case = ''.join(word.capitalize() if i > 0 else word for i, word in enumerate(attr.split('_')))

            if hasattr(item, snake_case):
                result[snake_case] = getattr(item, snake_case)
            elif hasattr(item, camel_case):
                result[snake_case] = getattr(item, camel_case)

    return result


# --- Lifespan Event Handler ---
@asynccontextmanager
async def lifespan(app: FastAPI):
    """Verwaltet Startup- und Shutdown-Events der Anwendung."""
    global app_start_time
    app_start_time = datetime.datetime.now()  # Setze Startzeit hier
    logger.info("====== WEBSITE WIRD GESTARTET ======")
    logger.info(f"Zeitstempel: {app_start_time.strftime('%Y-%m-%d %H:%M:%S')}")
    logger.info(f"Modus: READ-ONLY (keine Datenänderungen erlaubt)")
    db_connection_ok = check_database_connection()
    schema_ok = check_table_schema() if db_connection_ok else False

    if not db_connection_ok or not schema_ok:
        logger.warning("Die Anwendung läuft, aber es gibt Probleme mit der Datenbank!")
    else:
        logger.info("Alle Datenbank-Checks erfolgreich abgeschlossen.")
        count_items()
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
        return JSONResponse({"error": {"code": exc.status_code, "message": str(exc.detail)}},
                            status_code=exc.status_code)
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


@app.get("/sources")
async def sources(request: Request):
    """Quellen der Anwendung"""
    logger.debug(f"Route aufgerufen: /sources")
    template = templates.get_template("sources.html")
    content = template.render({"request": request})
    if is_ajax_request(request):
        return JSONResponse({"html": content})
    return templates.TemplateResponse("sources.html", {"request": request})


@app.get("/search")
async def search_page(request: Request):
    """Suchseite der Anwendung"""
    logger.debug(f"Route aufgerufen: /search")
    template = templates.get_template("search.html")
    content = template.render({"request": request})
    if is_ajax_request(request):
        return JSONResponse({"html": content})
    return templates.TemplateResponse("search.html", {"request": request})


@app.get("/api/search")
async def search_items(q: str = "", category: str = "", db: Session = Depends(get_db)):
    """API-Endpunkt für Suchfunktion, durchsucht alle Tabellen"""
    logger.debug(f"API-Aufruf: /api/search mit q={q}, category={category}")

    try:
        results = []
        search_term = f"%{q}%"

        # Entscheide, welche Tabellen abgefragt werden sollen
        if not category or category == "items":
            items = db.query(Item)
            if q:
                items = items.filter(
                    or_(
                        Item.name.ilike(search_term),
                        Item.textID.ilike(search_term),
                        Item.numID.ilike(search_term),
                        Item.description.ilike(search_term) if Item.description else False
                    )
                )
            results.extend([item.to_dict() for item in items.all()])

        if not category or category == "blocks":
            blocks = db.query(Block)
            if q:
                blocks = blocks.filter(
                    or_(
                        Block.name.ilike(search_term),
                        Block.textID.ilike(search_term),
                        Block.numID.ilike(search_term),
                        Block.description.ilike(search_term) if Block.description else False
                    )
                )
            results.extend([block.to_dict() for block in blocks.all()])

        if not category or category == "tools":
            tools = db.query(Tool)
            if q:
                tools = tools.filter(
                    or_(
                        Tool.name.ilike(search_term),
                        Tool.textID.ilike(search_term),
                        Tool.numID.ilike(search_term),
                        Tool.description.ilike(search_term) if Tool.description else False
                    )
                )
            results.extend([tool.to_dict() for tool in tools.all()])

        if not category or category == "armor":
            armors = db.query(Armor)
            if q:
                armors = armors.filter(
                    or_(
                        Armor.name.ilike(search_term),
                        Armor.textID.ilike(search_term),
                        Armor.numID.ilike(search_term),
                        Armor.description.ilike(search_term) if Armor.description else False
                    )
                )
            results.extend([armor.to_dict() for armor in armors.all()])

        if not category or category == "consumables":
            consumables = db.query(Consumable)
            if q:
                consumables = consumables.filter(
                    or_(
                        Consumable.name.ilike(search_term),
                        Consumable.textID.ilike(search_term),
                        Consumable.numID.ilike(search_term),
                        Consumable.description.ilike(search_term) if Consumable.description else False
                    )
                )
            results.extend([consumable.to_dict() for consumable in consumables.all()])

        if not category or category == "potions":
            potions = db.query(Potion)
            if q:
                potions = potions.filter(
                    or_(
                        Potion.name.ilike(search_term),
                        Potion.textID.ilike(search_term),
                        Potion.numID.ilike(search_term),
                        Potion.description.ilike(search_term) if Potion.description else False
                    )
                )
            results.extend([potion.to_dict() for potion in potions.all()])

        if not category or category == "other":
            others = db.query(Other)
            if q:
                others = others.filter(
                    or_(
                        Other.name.ilike(search_term),
                        Other.textID.ilike(search_term),
                        Other.numID.ilike(search_term),
                        Other.description.ilike(search_term) if Other.description else False
                    )
                )
            results.extend([other.to_dict() for other in others.all()])

        return results
    except Exception as e:
        logger.error(f"Fehler bei der Suche: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")


@app.get("/item/{item_id}")
async def item_detail(request: Request, item_id: str, db: Session = Depends(get_db)):
    """Detailseite für einzelne Items, durchsucht alle Tabellen"""
    logger.debug(f"Route aufgerufen: /item/{item_id}")
    try:
        item = None

        # Prüfen, ob es sich um eine numID oder textID handelt
        is_numeric = item_id.isdigit() or (":" in item_id and item_id.split(":")[0].isdigit())
        normalized_id = f"minecraft:{item_id.replace('-', '_')}"

        # Suche in allen Tabellen
        for model_class in [Item, Block, Tool, Armor, Consumable, Potion, Other]:
            if is_numeric:
                # Nach numID suchen
                result = db.query(model_class).filter(model_class.numID == item_id).first()
            else:
                # Nach textID suchen (direkt oder normalisiert)
                result = db.query(model_class).filter(
                    or_(
                        model_class.textID == item_id,
                        model_class.textID == normalized_id
                    )
                ).first()

            if result:
                item = result
                break

        if not item:
            logger.warning(f"Item nicht gefunden: {item_id}")
            return templates.TemplateResponse("error.html", {
                "request": request,
                "message": "Item not found",
                "status_code": 404
            }, status_code=404)

        # Objekt in Dictionary umwandeln
        item_dict = item_to_dict(item)

        # Icon-ID für CSS extrahieren
        item_id_css = ""
        if hasattr(item, 'textID') and item.textID and ':' in item.textID:
            item_id_css = item.textID.split(':')[1].replace('_', '-')

        return templates.TemplateResponse("item.html", {
            "request": request,
            "item": item_dict,
            "item_id": item_id_css
        })
    except Exception as e:
        logger.error(f"Fehler beim Abrufen des Items: {str(e)}")
        return templates.TemplateResponse("error.html", {
            "request": request,
            "message": f"An issue accrued while fetching the items: {str(e)}",
            "status_code": 500
        }, status_code=500)


@app.get("/random")
async def random_item(request: Request, db: Session = Depends(get_db)):
    """Weiterleitung zu einem zufälligen Item aus allen Tabellen"""
    logger.debug(f"Route aufgerufen: /random")

    try:
        # Sammle alle Tabellen und zähle Items
        item_tables = [
            (Item, "textID", "numID"),
            (Block, "textID", "numID"),
            (Tool, "textID", "numID"),
            (Armor, "textID", "numID"),
            (Consumable, "textID", "numID"),
            (Potion, "textID", "numID"),
            (Other, "textID", "numID")
        ]

        table_counts = []
        total_count = 0

        # Zähle Einträge in jeder Tabelle
        for model_class, id_field, fallback_field in item_tables:
            count = db.query(func.count(getattr(model_class, "numID"))).scalar() or 0
            if count > 0:
                table_counts.append((model_class, id_field, fallback_field, total_count, total_count + count))
                total_count += count

        if total_count == 0:
            logger.warning("Keine Items für Zufallsauswahl verfügbar")
            raise HTTPException(status_code=404, detail="No items are available for random selection")

        # Wähle einen zufälligen Index
        random_index = random.randint(0, total_count - 1)

        # Bestimme die Tabelle und den Offset
        for model_class, id_field, fallback_field, start_index, end_index in table_counts:
            if start_index <= random_index < end_index:
                offset = random_index - start_index
                random_item_obj = db.query(model_class).offset(offset).first()
                if random_item_obj:
                    # Versuche zuerst das primäre ID-Feld (textID)
                    item_id = getattr(random_item_obj, id_field)

                    # Fallback auf numID, wenn textID None ist
                    if item_id is None:
                        item_id = getattr(random_item_obj, fallback_field)
                        logger.debug(
                            f"Nutze Fallback-ID für zufälliges Item: {random_item_obj.name} (numID: {item_id})")
                    else:
                        logger.debug(f"Zufälliges Item ausgewählt: {random_item_obj.name} ({item_id})")

                    # Stelle sicher, dass item_id nicht None ist
                    if item_id is not None:
                        return create_redirect_response(request, f"/item/{item_id}")
                    else:
                        logger.warning(f"Zufälliges Item hat weder textID noch numID: {random_item_obj.name}")
                        # Weitersuchen nach einem gültigen Item
                        continue

        # Fallback, wenn kein Item gefunden wurde
        raise HTTPException(status_code=404, detail="Konnte kein zufälliges Item auswählen")
    except Exception as e:
        logger.error(f"Fehler bei der Zufallsauswahl: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Any issue acured in the random selection: {str(e)}")


@app.get("/data")
async def show_data(request: Request, db: Session = Depends(get_db)):
    """Zeigt alle Daten aus allen Tabellen"""
    results = []

    # Sammle Daten aus allen Tabellen
    for model_class in [Item, Block, Tool, Armor, Consumable, Potion, Other]:
        items = db.query(model_class).all()
        results.extend([item_to_dict(item) for item in items])

    return templates.TemplateResponse("raw.html", {"request": request, "data": results})


@app.get("/api/items")
async def search_items_api(
        request: Request,
        query: str = "",
        category: str = "",
        db: Session = Depends(get_db)):
    """API für die Suche nach Items (alle Tabellen)"""
    logger.debug(f"API aufgerufen: /api/items mit query={query}, category={category}")

    try:
        results = []
        search_term = f"%{query}%"

        # Definition der Tabellen und Klassen für die Suche
        tables_to_search = []

        if not category or category == "all":
            tables_to_search = [
                (Item, "items"),
                (Block, "blocks"),
                (Tool, "tools"),
                (Armor, "armor"),
                (Consumable, "consumables"),
                (Potion, "potions"),
                (Other, "other")
            ]
        else:
            # Nur die angeforderte Kategorie
            category_map = {
                "items": Item,
                "blocks": Block,
                "tools": Tool,
                "armor": Armor,
                "consumables": Consumable,
                "potions": Potion,
                "other": Other
            }

            if category in category_map:
                tables_to_search = [(category_map[category], category)]

        # Durchsuche jede ausgewählte Tabelle
        for model_class, cat_name in tables_to_search:
            items_query = db.query(model_class)

            # Suchfilter anwenden
            if query:
                if hasattr(model_class, "name") and hasattr(model_class, "textID") and hasattr(model_class, "numID"):
                    items_query = items_query.filter(
                        or_(
                            model_class.name.ilike(search_term),
                            model_class.textID.ilike(search_term),
                            model_class.numID.ilike(search_term),
                            model_class.description.ilike(search_term) if hasattr(model_class, "description") else False
                        )
                    )

            # Ergebnisse abrufen
            items = items_query.all()

            # In Dictionary umwandeln und Kategorie hinzufügen
            for item in items:
                item_dict = item_to_dict(item)
                if "category" not in item_dict:
                    item_dict["category"] = cat_name
                results.append(item_dict)

        return {"items": results}

    except Exception as e:
        logger.error(f"Fehler bei der API-Suche: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")


# --- Weitere Routen ---
@app.get("/options")
async def options(request: Request):
    """Optionen-Seite (noch nicht implementiert)"""
    logger.debug(f"Route aufgerufen: /options (nicht implementiert)")
    raise HTTPException(status_code=501, detail="Not implemented yet")


@app.get("/quit")
async def leave(request: Request):
    """Verlassen der Anwendung"""
    logger.debug(f"Route aufgerufen: /quit (Weiterleitung)")
    return create_redirect_response(request, "https://youtu.be/dQw4w9WgXcQ")


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
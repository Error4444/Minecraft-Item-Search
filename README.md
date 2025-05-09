# Minecraft Item Suchmaschine

## Kurzbeschreibung

Dieses Projekt ist eine Webanwendung, die es Benutzern ermöglicht, Minecraft-Items (Version 1.0) zu durchsuchen und detaillierte Informationen zu jedem Item anzuzeigen. Die Anwendung bietet eine Suchfunktion mit Filteroptionen nach Kategorien und eine Detailansicht für einzelne Items. Das Design ist an die Ästhetik von Minecraft angelehnt.

## Hauptfunktionen

*   **Item-Suche:** Benutzer können nach Items anhand ihres Namens suchen.
*   **Kategorie-Filter:** Suchergebnisse können nach Item-Kategorien gefiltert werden (z.B. Blöcke, Werkzeuge, Rüstung).
*   **Dynamische Suchergebnisse:** Die Suchergebnisse werden dynamisch auf der Seite geladen, ohne dass ein Neuladen der Seite erforderlich ist.
*   **Item-Detailansicht:** Für jedes Item gibt es eine eigene Seite, die detaillierte Informationen wie ID, numerische ID, Kategorie, Stapelgröße, Herstellbarkeit und eine Beschreibung anzeigt.
*   **Responsive Navigation:** Eine an das Minecraft-Design angelehnte Navigation führt zurück zur Suche oder zum Hauptmenü.
*   **Fehlerseiten:** Benutzerdefinierte Fehlerseiten für eine bessere Benutzererfahrung.

## Technologie-Stack

*   **Backend:**
    *   Python
    *   FastAPI (Web-Framework)
    *   SQLAlchemy (ORM für Datenbankinteraktion)
    *   MySQL oder PostgreSQL (Datenbank)
    *   Jinja2 (Template-Engine für HTML-Rendering)
*   **Frontend:**
    *   HTML5
    *   CSS3 (mit benutzerdefinierten Schriftarten und Design im Minecraft-Stil)
    *   JavaScript (für dynamische Inhalte, API-Aufrufe und Interaktivität)
*   **Server-Konfiguration:**
    *   `web.config` ermöglicht eine Bereitstellung auf einem IIS-Server (Windows).

## Voraussetzungen

Um das Projekt lokal auszuführen oder weiterzuentwickeln, benötigen Sie folgende Software:

*   Python (Version 3.11.9 oder kompatibel)
*   Einen ASGI-Server wie Uvicorn (um FastAPI-Anwendungen auszuführen)
*   Eine laufende PostgreSQL-Datenbankinstanz
*   Die in der `requirements.txt` aufgeführten Python-Pakete. Die wichtigsten sind:
    *   `fastapi`
    *   `uvicorn`
    *   `sqlalchemy`
    *   `psycopg2-binary` (oder ein anderer PostgreSQL-Treiber für SQLAlchemy)
    *   `jinja2`
    *   `python-dotenv` (üblicherweise zur Verwaltung von Umgebungsvariablen)
*   Ein moderner Webbrowser (für die Frontend-Anzeige)

## Installation

1.  **Repository klonen:**
    ```bash
    git clone <repository-url>
    cd minecraft-item-search # Oder der Name Ihres Projektordners
    ```
2.  **Virtuelle Umgebung erstellen und aktivieren:**
    ```bash
    python -m venv venv
    # Windows
    venv\Scripts\activate
    # macOS/Linux
    source venv/bin/activate
    ```
3.  **Abhängigkeiten installieren:**
    (Nutzen Sie die `requirements.txt`-Datei mit den notwendigen Paketen oder installieren Sie sie manuell)
    ```bash
    pip install fastapi uvicorn sqlalchemy psycopg2-binary jinja2 python-dotenv
    ```
4.  **Umgebungsvariablen konfigurieren:**
    Erstellen Sie eine `.env`-Datei im Stammverzeichnis des Projekts und fügen Sie die erforderlichen Datenbankverbindungsinformationen hinzu:
    ```env
    DB_USER=your_db_user
    DB_PASSWORD=your_db_password
    DB_HOST=your_db_host
    DB_NAME=your_db_name
    ```
5.  **Datenbank initialisieren:**
    Stellen Sie sicher, dass die Datenbank und die Tabellenstruktur (wie in der Klasse `Item` in `website.py` definiert) existieren. Möglicherweise müssen Sie ein Skript zur Erstellung der Tabellen ausführen (nicht im bereitgestellten Code enthalten).

## Ausführen der Anwendung

Um den FastAPI-Entwicklungsserver zu starten (normalerweise mit Uvicorn):
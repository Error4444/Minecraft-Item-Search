// Sicherstellen, dass das DOM vollständig geladen ist
document.addEventListener('DOMContentLoaded', function() {
    // Referenzen auf DOM-Elemente
    const searchInput = document.getElementById('searchInput');
    const filterButton = document.getElementById('filterButton');
    const searchResults = document.getElementById('searchResults');
    const filterOptions = document.querySelectorAll('.filter-option');
    const currentFilterElement = filterButton ? filterButton.querySelector('.current-filter') : null;
    const itemTemplate = document.getElementById('item-template');

    // Anfänglicher Kategoriefilter
    let currentFilter = '';
    let debounceTimer;

    // Hilfsfunktion für Debounce
    function debounce(func, wait) {
        return function(...args) {
            clearTimeout(debounceTimer);
            debounceTimer = setTimeout(() => func.apply(this, args), wait);
        };
    }

    // Event-Listener für das Sucheingabefeld
    if (searchInput) {
        searchInput.addEventListener('input', debounce(performSearch, 300));

        const cursorBlinker = document.getElementById('cursorBlinker');
        if (cursorBlinker) {
            function updateCursorPosition() {
                if (!cursorBlinker || !searchInput) return;
                const text = searchInput.value;
                cursorBlinker.style.left = (text.length * 8 + 16) + 'px';
            }

            searchInput.addEventListener('focus', () => {
                cursorBlinker.style.display = 'block';
                updateCursorPosition();
            });
            searchInput.addEventListener('blur', () => {
                cursorBlinker.style.display = 'none';
            });
            searchInput.addEventListener('input', updateCursorPosition);

            if (document.activeElement === searchInput) {
                cursorBlinker.style.display = 'block';
            } else {
                cursorBlinker.style.display = 'none';
            }
            updateCursorPosition();
        }
    }

    // Event-Listener für den Filterbutton
    if (filterButton) {
        filterButton.addEventListener('click', function(e) {
            e.stopPropagation();
            this.classList.toggle('active');
        });

        // Schließen, wenn außerhalb geklickt wird
        document.addEventListener('click', () => {
            filterButton.classList.remove('active');
        });
    }

    // Event-Listener für die Filteroptionen
    if (filterOptions && currentFilterElement && filterButton) {
        filterOptions.forEach(option => {
            option.addEventListener('click', function(e) {
                e.stopPropagation();
                const value = this.getAttribute('data-value');
                const text = this.textContent;
                currentFilter = value;

                // Update der ausgewählten Filteroption im UI
                currentFilterElement.textContent = text;
                filterButton.classList.remove('active');

                // Suche mit dem neuen Filter ausführen
                performSearch();
            });
        });
    }

    // Funktion zur Ausführung der Suche
    async function performSearch() {
        const searchTerm = searchInput ? searchInput.value.trim() : '';

        try {
            // API-Anfrage für die Suche
            const response = await fetch(`/api/search?q=${encodeURIComponent(searchTerm)}&category=${encodeURIComponent(currentFilter)}`);
            if (!response.ok) {
                throw new Error(`Network response was not ok: ${response.statusText}`);
            }
            const items = await response.json();
            displaySearchResults(items);
        } catch (error) {
            console.error('Error performing search:', error);
            if(searchResults) {
                searchResults.innerHTML = '<div class="no-results">Fehler beim Laden der Items</div>';
            }
        }
    }

    // Funktion zur Anzeige der Suchergebnisse
    function displaySearchResults(items) {
        if (!searchResults || !itemTemplate) return;

        // Löschen vorheriger Ergebnisse
        searchResults.innerHTML = '';

        if (!Array.isArray(items)) {
             console.error("Received non-array data:", items);
             searchResults.innerHTML = '<div class="no-results">Fehler: Ungültige Daten empfangen</div>';
             return;
        }

        if (items.length === 0) {
            searchResults.innerHTML = '<div class="no-results">Keine Items gefunden</div>';
            return;
        }

        // Rendern jedes Items
        items.forEach(item => {
            // Überprüfen, ob das Item-Objekt die erwarteten Eigenschaften hat
            if (!item) {
                console.warn("Skipping null item");
                return;
            }

            // Bestimme die Werte für die Anzeige mit Fallbacks
            const itemName = item.name || 'Unbekannt';
            const itemId = item.id || item.textID || '';
            const itemCssId = getItemCssId(item);
            const itemNumber = item.number || item.numID || '';
            const itemCategory = getCategoryName(item.category || '');

            const itemElement = document.createElement('div');

            // Template-HTML mit Item-Daten füllen
            let itemHTML = itemTemplate.innerHTML
                .replace(/{name}/g, itemName)
                .replace(/{category}/g, itemCategory)
                .replace(/{id}/g, itemId)
                .replace(/{item_id}/g, itemCssId)
                .replace(/{number}/g, itemNumber);

            // HTML-Struktur aus dem Template erstellen
            itemElement.innerHTML = itemHTML;

            const actualItemElement = itemElement.firstElementChild;

            if (actualItemElement) {
                 // Bestimme die korrekte URL für die Detailseite
                 const itemLink = getItemLink(item);

                 // Hinzufügen von Event-Listenern
                actualItemElement.addEventListener('click', () => {
                    window.location.href = itemLink;
                });
                searchResults.appendChild(actualItemElement);
            } else {
                console.warn("Could not create item element from template for item:", item);
            }
        });
    }

    // Hilfsfunktion zur Ermittlung des CSS-freundlichen Item-IDs
    function getItemCssId(item) {
        // Versuche, einen CSS-freundlichen Bezeichner zu erstellen
        if (item.item_id) {
            return item.item_id;
        }

        let id = '';
        if (item.id) {
            id = item.id;
        } else if (item.textID) {
            id = item.textID;
        }

        // Extrahiere den Teil nach dem Doppelpunkt (falls vorhanden)
        if (id && id.includes(':')) {
            return id.split(':')[1].replace(/_/g, '-');
        }

        // Entferne minecraft: Präfix und ersetze Unterstriche durch Bindestriche
        return id.replace('minecraft:', '').replace(/_/g, '-') || 'unknown';
    }

    // Hilfsfunktion zum Ermitteln des korrekten Links für die Detailseite
    function getItemLink(item) {
        // Bestimme den besten Wert für den Item-Link
        if (item.id) {
            return `/item/${item.id}`;
        } else if (item.textID) {
            return `/item/${item.textID}`;
        } else if (item.numID) {
            return `/item/${item.numID}`;
        } else if (item.number) {
            return `/item/${item.number}`;
        }

        // Fallback
        return '/search';
    }

    // Hilfsfunktion zum Umwandeln der Kategorie in lesbare Form
    function getCategoryName(category) {
        if (!category) return '';

        const categoryMap = {
            'blocks': 'Block',
            'items': 'Item',
            'tools': 'Werkzeug',
            'armor': 'Rüstung',
            'consumables': 'Verbrauchsgegenstand',
            'potions': 'Trank',
            'other': 'Sonstiges'
        };

        return categoryMap[category] || category;
    }

    // Führt beim Laden der Seite eine initiale Suche durch
    performSearch();
});
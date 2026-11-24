# 🏆 Zippo Tournament Manager

![Platforma](https://img.shields.io/badge/Platforma-Windows%207%20%7C%208%20%7C%2010%20%7C%2011-blue?style=for-the-badge&logo=windows)
![Technologia](https://img.shields.io/badge/Technologia-.NET%2010.0-purple?style=for-the-badge&logo=dotnet)
![Status](https://img.shields.io/badge/Status-Produkcyjny-success?style=for-the-badge)
![Format](https://img.shields.io/badge/Rozgrywki-BO3%20%28Best%20of%203%29-orange?style=for-the-badge)

**Zippo Tournament Manager** to zaawansowana aplikacja konsolowa przeznaczona do kompleksowej obsługi i zarządzania turniejami e-sportowymi oraz sportowymi. Pozwala na sprawne tworzenie drużyn, zarządzenie zawodnikami, automatyczne generowanie spotkań w formacie **Best of 3 (BO3)**, pełną analitykę statystyczną oraz bezobsługowy zapis i odczyt stanu w formacie **JSON**.

---

## 📁 Struktura Folderu

Paczka produkcyjna znajduje się w katalogu `ZippoTournamentManager publish/` i zawiera następujące pliki:

```text
ZippoTournamentManager publish/
├── setup.bat                   # Uniwersalny instalator środowiska .NET 10
├── ZippoTournamentManager.exe  # Główna aplikacja wykonywalna
├── ZippoTournamentManager.pdb  # Plik symboli debugowania
└── daneTurniejowe.json         # Plik bazy danych JSON (tworzony automatycznie po uruchomieniu)
```

---

## 🚀 Szybki Start i Instalacja

Program nie wymaga żadnej skomplikowanej konfiguracji. Możesz go uruchomić bezpośrednio lub skorzystać z dołączonego skryptu sprawdzającego środowisko.

### Krok 1: Weryfikacja środowiska (`setup.bat`)

Jeżeli uruchamiasz program na nowym komputerze, uruchom plik `setup.bat`:
1. Kliknij prawym przyciskiem myszy na plik **`setup.bat`**.
2. Wybierz opcję **Uruchom jako administrator**.
3. Skrypt automatycznie:
   - Wykryje wersję Twojego systemu Windows (Windows 11, 10, 8.1, 8 lub 7).
   - Sprawdzi obecność bibliotek **.NET 10 Runtime**.
   - W przypadku ich braku samoczynnie pobierze i zainstaluje je za pomocą Menedżera Pakietów `winget` lub bezpośrednio z oficjalnych serwerów Microsoft przez PowerShell.

### Krok 2: Uruchomienie aplikacji

Dwukrotnie kliknij plik **`ZippoTournamentManager.exe`**, aby uruchomić menedżer turniejowy.

---

## ✨ Pełna Lista Funkcjonalności

### 👤 1. Zarządzanie Zawodnikami
* **Dodawanie zawodników:** Wprowadzanie graczy z automatyczną walidacją duplikatów (niewrażliwą na wielkość liter i spacje).
* **Wyświetlanie i wyszukiwanie:** Przeglądanie pełnej listy oraz szybka wyszukiwarka zawodników po nazwie.
* **Edycja i usuwanie:** Zmiana nazw oraz usuwanie zawodników (z wbudowanym zabezpieczeniem przed usunięciem gracza przydzielonego do jakiejkolwiek drużyny).
* **Sortowanie:** Alfabetyczne sortowanie listy zawodników z natychmiastową aktualizacją bazy danych.

### 🛡️ 2. Zarządzanie Drużynami
* **Tworzenie składów:** Zestawianie 3-osobowych drużyn z puli wolnych zawodników.
* **Kontrola przydziału:** Jeden zawodnik nie może występować w więcej niż jednej drużynie jednocześnie.
* **Edycja składów i nazw:** Zmiana nazwy drużyny oraz wymiana poszczególnych zawodników na wolnych graczy.
* **Ochrona spójności:** Brak możliwości usunięcia drużyny, która jest przypisana do jakiegokolwiek turnieju.

### 🏟️ 3. Zarządzanie Turniejami
* **Tworzenie turniejów:** Rejestracja turnieju z nazwą oraz datami rozpoczęcia i zakończenia.
* **Dynamiczne statusy:** Automatic sprawdzanie statusu na podstawie aktualnego czasu:
  * 🔵 **NADCHODZĄCY**
  * 🟡 **W TRAKCIE**
  * 🟢 **ZAKOŃCZONY**
* **Zarządzanie uczestnikami:** Dodawanie drużyn do turnieju oraz ich usuwanie (usunięcie drużyny z turnieju automatycznie czyści powiązane z nią mecze i aktualizuje identyfikatory).

### ⚔️ 4. Obsługa Meczy i Wyników
* **Planowanie meczy:** Tworzenie pojedynków między drużynami w obrębie danego turnieju.
* **Rygorystyczny format BO3:** Wynik meczu może przyjmować wyłącznie prawidłowe wartości formatu Best of 3:
  * `2:0`, `2:1`, `0:2`, `1:2`
* **Ochrona przed nadpisaniem:** Zakończony mecz nie może mieć ponownie zmienionego wyniku.

### 📊 5. Statystyki i Analityka
* **Statystyki drużynowe w turnieju:**
  * Liczba zwycięstw (**W**) oraz porażek (**L**).
  * Procent wygranych (**% winów**).
  * Zdobyte i stracone punkty.
  * Bilans punktowy.
* **Podsumowanie turnieju:** Automatyczny wybór **Najlepszej Drużyny** oraz drużyny z **Najwyższym Wynikiem** w pojedynczym spotkaniu.

### 💾 6. Automatyczna Persystencja Danych (JSON)
Wszystkieoperacje wykonywane w programie (dodanie zawodnika, zmiana nazwy, wprowadzenie wyniku) są natychmiastowo utrwalane w pliku `daneTurniejowe.json`. Po ponownym uruchomieniu aplikacja wczytuje pełny stan bez utraty danych.

---

## 💻 Wymagania Systemowe

| Cecha | Wymaganie |
| :--- | :--- |
| **System operacyjny** | Windows 7 / 8 / 8.1 / 10 / 11 (32-bit lub 64-bit) |
| **Środowisko uruchomieniowe** | .NET 10.0 Runtime (instalowane automatycznie przez `setup.bat`) |
| **Konsola** | Windows Terminal lub Standardowy Wiersz Poleceń (CMD / PowerShell) |

---

## 🛠️ Technologie i Architektura

* **Język programowania:** C#
* **Platforma:** .NET 10.0 Console Application
* **Format zapisu:** `System.Text.Json` z obsługą relacji obiektowych i referencji
* **Instalator skryptowy:** Windows Batch Script (`setup.bat`) z automatycznym przełączaniem źródeł (`winget` / `PowerShell Direct Download`), wykrywaniem administratora (`net session`) oraz stylizacją UTF-8 / ANSI Colors.

---

## 👨‍💻 Autor

Projekt stworzony przez **ZippobssDEV** (`zippobss777`).

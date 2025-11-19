# Library Database Project
**Ruslan Zakruzhetskyi**

MySQL database for a library system. Includes 15+ tables, PK/FK, views, procedures, and 20+ records per table.

## Files
- `bibliotekaruslan_zakruzhetskyi_FULL.sql` → Full database (import once)
- `create_bibliotekaruslan_zakruzhetskyi.sql` → Schema only
- `insert_data.sql` → Data only (20+ per table)

## How to Import
1. phpMyAdmin → Create database `bibliotekaruslan_zakruzhetskyi`
2. Import `create_...sql` → then `insert_data.sql`

   Or just import `FULL.sql`.

## Recent updates (November 2025)
- Clients can now have two separate addresses (registration + correspondence) using many-to-many relationship  
  → new tables: `typy_adresow` + `uzytkownicy_adresy` (old table `adresy` removed)
- Added table `pracownicy` (Id, Imie, Nazwisko, DataUrodzenia, Stanowisko)
- All primary keys already use AUTO_INCREMENT
- Added queries for:
  • alphabetical client list
  • loans sorted by date (descending)
  • workers born after 1999 or older than 40 years
  • filtering clients by specific ID ranges
  • joining books with authors (title + author name + ISBN)
  • total number of clients (COUNT)
  • most and least borrowed books with full details and loan count

Everything still works with the same 3 files.  
Update: November 2025

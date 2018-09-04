
# SQLite3 Cheatsheet

**Before installing SQLite it's always good to**
- `brew upgrade`
- `brew update`

**Install SQLite**
- `brew install sqlite3`

**Drop into the SQLite shell:**
- `sqlite3`

**Your terminal will look something like this:**
```
SQLite version 3.8.10.2 2015-05-20 18:17:19
Enter ".help" for usage hints.
sqlite>
```

**To exit:**
- `control + c` twice, or
- `.quit`

**Or drop directly into specific database in SQLite shell:**
- `sqlite3 database-name.db`

**Once you're in `sqlite3`, you can switch between databases:**
- `sqlite> .open other-database.db`


**Note:** both of the above commands will create a database if none found with the name you supplied.

---


**See your current database:**
- `.database`

**See all tables in current database:**
- `.tables`

**You can write SQL commands in a file and run them against a specific db:**
- `$ sqlite3 db_name < file.sql`

**See all rows in a specific table:**
- `SELECT * FROM tablename;`

**See all columns in a specific table:**
- `pragma table_info(tablename);`


---

# Create schema for each table

```
CREATE TABLE users (
  id integer PRIMARY KEY AUTOINCREMENT,
  fname varchar(50),
  lname varchar(50),
  dateCreated timestamp DEFAULT current_timestamp
);
```

---


# CRUD actions in SQLite


## Create
**Create a entry**
- `INSERT INTO users (fname) VALUES ('Juan');`
- `INSERT INTO users (fname, lname) VALUES ('Juan', 'Juanson');`

## Read
**Read all entries from a table:**
- `SELECT * FROM users;`

**Read a single entry from a table using WHERE statement:**
- `SELECT * FROM users WHERE fname = 'brian';`

**Read all entries in specific column:**
- `SELECT (fname) FROM users;`
- `SELECT (fname) FROM users WHERE fname = 'brian';`

## Update
**To update a single entry:**
- `UPDATE users SET fname = 'john' WHERE fname = 'brian';`

**To update every single entry in a table:**
- `UPDATE users SET fname = 'john';`

## Destroy
**Delete a specific entry:**
- `DELETE FROM users WHERE fname = 'Juan';`

**Delete all entries in a specific table:**
- `DELETE FROM users;`

**Delete a table:**
- `DROP TABLE IF EXISTS users;`



















#

require "./whitedb/*"

# Connecting to the database
db : Void*
rec : Void*; rec2 : Void*

db = WhiteDB.attach_database "dick", 200_000

# Adding data to the database
## Records
rec = WhiteDB.create_record(db, 10)
rec2 = WhiteDB.create_record(db, 2)

# Data in WhiteDB
enc = WhiteDB.encode_int(db, 443)
enc2 = WhiteDB.encode_str(db, "this is my string", nil)

## Setting field values
WhiteDB.set_field(db, rec, 7, enc)
WhiteDB.set_field(db, rec2, 0, enc2)

# Making Requests
## Finding matching records
rec = WhiteDB.find_record_int(db, 7, WhiteDB::COND::EQUAL, 443, nil)


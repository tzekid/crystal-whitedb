require "../src/whitedb/*"

exit(1) unless db = WhiteDB.attach_database("1000", 2_000_000)

rec = WhiteDB.create_record(db, 2)
rec2 = WhiteDB.create_record(db, 3)
rec3 = WhiteDB.create_record(db, 4)

exit(2) unless (rec || rec2 || rec3)

# Add some content
WhiteDB.set_field(db, rec, 1, WhiteDB.encode_str(db, "hello", nil))
WhiteDB.set_field(db, rec2, 0, WhiteDB.encode_str(db, "I'm pointing to other records", nil))
WhiteDB.set_field(db, rec3, 1, WhiteDB.encode_str(db, "I'm linked from two records", nil))

# link the records to each other
enc = WhiteDB.encode_record(db, rec)
WhiteDB.set_field(db, rec2, 2, enc) # rec2[2] points to rec
enc = WhiteDB.encode_record(db, rec3)
WhiteDB.set_field(db, rec2, 1, enc) # rec2[1] points to rec3
WhiteDB.set_field(db, rec, 0, enc) # rec[0] points to rec3

WhiteDB.detach_database(db)

WhiteDB.print_db(db)
WhiteDB.detach_database(db)

print "Press enter to continue..."; gets
WhiteDB.delete_database("1000")

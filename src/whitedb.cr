require "./whitedb/*"

#> Examples taken from: https://whitebd.org/tutorial

# db : Void*
# rec : Void*; rec2 : Void*
# enc : Void*; enc2 : Void*

# Connecting to the database
db = WhiteDB.attach_database "dbname", 200_000

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
### -> "field 7 equals 443"
rec = WhiteDB.find_record_int(db, 7, WhiteDB::COND::EQUAL, 443, nil)
while rec
  puts "Found a record where field 7 is 443"
  rec = WhiteDB.find_record_int(db, 7, WhiteDB::COND::EQUAL, 443, rec);
end

## Full query interface
arglist = WhiteDB::QueryArg.new
arglist = Slice(WhiteDB::QueryArg).new(2, arglist) # Doc. this behaviour

arglist[0].column = 7
arglist[0].cond = WhiteDB::COND::EQUAL
arglist[0].value = WhiteDB.encode_query_param_int(db, 443)

arglist[1].column = 6
arglist[1].cond = WhiteDB::COND::EQUAL
arglist[1].value = WhiteDB.encode_query_param_null(db, nil)

# -> "field 7 equals 443 and field 6 equals NULL"
query = WhiteDB.make_query(db, nil, 0, arglist, 2) #< arglist should be a pointer (of queryargs)

while rec = WhiteDB.fetch(db, query)
  puts "Found a record where field 7 is 443 and field 6 is NULL"
end

# Free the memory allocated for the query
WhiteDB.free_query(db, query)
WhiteDB.free_query_param(db, arglist[0].value)
WhiteDB.free_query_param(db, arglist[1].value)

print "Press enter to continue..."; gets
WhiteDB.delete_database("dbname")

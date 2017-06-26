require "../src/whitedb/*"

#> Example taken from: http://whitedb.org/tutorial.html#_doing_things_properly

db = WhiteDB.attach_database("1000", 1_000_000)
(puts "DB could not be initialized"; exit 1 ) unless db

i = 0
lastrec = nil
loop do
  rec = WhiteDB.create_record(db, 1)
  (puts "ERR: Failed to create record. Made #{i} so far"; break) unless rec

  lastrec = rec
  enc = WhiteDB.encode_str(db, i.to_s, nil)
  (puts "ERR: Failed to encode string (#{i} records currently)"; break) if enc == WhiteDB::ILLEGAL
  
  # TODO(kid): Whiy does it only work when negated? (i.e. exactly the opp. of the C API)  
  if ! WhiteDB.set_field(db, rec, 0, enc)
    puts "ERR: Dis error's less likely, but wg_set_field() failed"
    break;
  end
  i += 1
end

# For educational purposes, let's pretend we're interested in what's stored in the last record
if lastrec
  str = WhiteDB.decode_str(db, WhiteDB.get_field(db, lastrec, 0))
  if !str
    puts "ERR: Decoding the string field failed."
    if WhiteDB.get_field_type(db, lastrec, 0) != WhiteDB::TYPE::STR
      puts "ERR: The field type is not string - should have checked that first !"
    end
  end
end

WhiteDB.detach_database(db)

print "Press enter to continue..."; gets

WhiteDB.delete_database("1000")

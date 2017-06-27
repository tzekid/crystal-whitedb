require "../src/whitedb/*"

#> Example taken from: http://whitedb.org/tutorial.html#_parallel_use

NUM_INCREMENTS = 100_000

def die(db : Void*, err : Int)
  WhiteDB.detach_database(db)
  exit(err) 
end

exit(1) unless (db = WhiteDB.attach_database("1000", 1_000_000)) 

lock_id = WhiteDB.start_read(db)
rec = WhiteDB.get_first_record(db)

WhiteDB.end_read(db, lock_id)

unless rec
  # There is no record yet, we're the first to run and have to set up the counter
  lock_id = WhiteDB.start_write(db)
  die(db, 2) unless lock_id
  rec = WhiteDB.create_record(db, 1)
  WhiteDB.end_write(db, lock_id)

  die(db, 3) unless rec
  print "Press a key when all the counter programs have been started"; gets

  # Setting the counter to 0 lets each counting program know it can start counting now.
  lock_id = WhiteDB.start_write(db)
  die(db, 2) unless lock_id
  WhiteDB.set_field(db, rec, 0, WhiteDB.encode_int(db, 0))
  WhiteDB.end_write(db, lock_id)
else
  # Some other program has started first, we wait until the counter is ready

  ready = 0
  until ready
    lock_id = WhiteDB.start_read(db)
    die(db, 2) unless lock_id
    
    ready = 1 if WhiteDB.get_field_type(db, rec, 0) == WhiteDB::TYPE::INT
    
    WhiteDB.end_read(db, lock_id)
  end
end

val = 0
(0...NUM_INCREMENTS).each do |i|
  lock_id = WhiteDB.start_write(db)
  die(db, 2) unless lock_id

  # This is the "critical section" for the counter. We read the value,
  # increment it and write it back.
  @val = WhiteDB.decode_int(db, WhiteDB.get_field(db, rec, 0))
  WhiteDB.set_field(db, rec, 0, WhiteDB.encode_int(db, @val += 1)) # TODO(kid): how to ++val in crystal ?

  WhiteDB.end_write(db, lock_id)
end

puts "\nCounting done. My last value was #{val}"

WhiteDB.print_db(db)
WhiteDB.detach_database(db)

print "Press enter to continue..."; gets
WhiteDB.delete_database("1000")

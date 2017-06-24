@[Link("wgdb")]
lib WhiteDB
  alias Int = Int64
  alias Char = LibC::Char
  alias Long = LibC::Long
  alias Double = LibC::Double
  alias UInt = LibC::UInt
  alias TimeT = LibC::TimeT
  alias SizeT = LibC::SizeT
  alias Short = LibC::Short
  alias Int64T = LibC::Int64T

  alias String = LibC::Char*


  fun attach_database = wg_attach_database(dbasename : String, size : Int) : Void*
  fun attach_exisitng_database = wg_attach_exisitng_database(Char*) : Void*
  fun attach_logged_database = wg_attach_logged_database(Char*, Int, Int) : Void*
  fun attach_database_mode = wg_attach_database_mode(Char*, Int, Int) : Void*
  fun detach_database = wg_detach_database(Void*) : Int
  fun delete_database = wg_delete_database(Char*) : Int
  

  fun attach_local_database = wg_attach_local_database(Int) : Void*
  fun delete_local_database = wg_delete_local_database(db : Void*) : Void

  
  fun create_record = wg_create_record(db : Void*, length : Int) : Void*
  fun create_raw_record = wg_create_raw_record(Void*, Int) : Void*
  fun delete_record = wg_delete_record(Void*, Void*) : Int
  fun get_first_record = wg_get_first_record(Void*) : Void*
  fun get_next_record = wg_get_next_record(Void*, Void*) : Void*
  fun get_first_parent = wg_get_first_parent(Void*, Void*) : Void*
  fun get_next_parent = wg_get_next_parent(Void*, Void*, Void*) : Void*

  
  fun get_record_len = wg_get_record_len(Void*, Void*) : Int
  
  fun set_field = wg_set_field(db : Void*, record_ : Void*, fieldnr : Int, data : Int) : Int
  fun set_new_field = wg_set_new_field(Void*, Void*, Int, Int) : Int
  
  fun get_field = wg_get_field(Void*, Void*, Int) : Int
  fun get_field_type = wg_get_field_type(Void*, Void*, Int) : Int
  
  fun set_int_field = wg_set_int_field(Void*, Void*, Int, Int) : Int
  fun set_double_field = wg_set_double_field(Void*, Void*, Int, Double) : Int
  fun set_str_field = wg_set_str_field(Void*, Void*, Int, Char*) : Int
  
  fun field_arr = wg_field_arr(Void*, Void*, Int) : Int


  enum Types
    WG_NULLTYPE = 1
    WG_RECORDTYPE
    WG_INTTYPE
    WG_DOUBLETYPE
    WG_STRTYPE
    WG_XMLLITERALTYPE
    WG_URITYPE
    WG_BLOBTYPE
    WG_CHARTYPE
    WG_FIXPOINTTYPE
    WG_DATETYPE
    WG_TIMETYPE
  end


  fun get_encoded_type = wg_get_encoded_type(Void*, Int) : Int
  fun free_encoded = wg_free_encoded(Void*, Int) : Int

  fun encode_null = wg_encode_null(Void*, Int) : Int
  fun decode_null = wg_decode_null(Void*, Int) : Int

  fun encode_int = wg_encode_int(int : Void*, data : Int) : Int
  fun decode_int = wg_decode_int(int : Void*, data : Int) : Int

  fun encode_char = wg_encode_char(Void*, Char) : Int
  fun decode_char = wg_decode_char(Void*, Int) : Char

  fun encode_record = wg_encode_record(Void*, Void*) : Int
  fun decode_record = wg_decode_record(Void*, Int) : Void*

  fun encode_double = wg_encode_double(Void*, Double) : Int
  fun decode_double = wg_decode_double(Void*, Int);

  fun encode_fixpoint = wg_encode_fixpoint(Void*, Double) : Int
  fun decode_fixpoint = wg_decode_fixpoint(Void*, Int);

  fun encode_date = wg_encode_date(Void*, Int) : Int
  fun wg_decode_date(Void*, Int) : Int

  fun encode_time = wg_encode_time(Void*, Int) : Int
  fun wg_decode_time(Void*, Int) : Int

  fun wg_current_utcdate(Void*) : Int
  fun wg_current_localdate(Void*) : Int
  fun wg_current_utctime(Void*) : Int
  fun wg_current_localtime(Void*) : Int

  fun wg_strf_iso_datetime(Void*, Int, Int, Char*) : Int
  fun wg_strp_iso_date(Void*, Char*) : Int
  fun wg_strp_iso_time(Void*, Char*) : Int

  fun wg_ymd_to_date(Void*, Int, Int, Int) : Int
  fun wg_hms_to_time(Void*, Int, Int, Int, Int) : Int
  fun date_to_ymd = wg_date_to_ymd(Void*, Int, Int*, Int*, Int*) : Void*
  fun time_to_hms = wg_time_to_hms(Void*, Int, Int*, Int*, Int*, Int*) : Void*

  fun encode_str = wg_encode_str(db : Void*, str : Char*, lang : Char*) : Int

  fun decode_str = wg_decode_str(Void*, Int) : Char*
  fun decode_str_lang = wg_decode_str_lang(Void*, Int) : Char*

  fun decode_str_len = wg_decode_str_len(Void*, Int) : Int
  fun decode_str_lang_len = wg_decode_str_lang_len(Void*, Int) : Int
  fun decode_str_copy = wg_decode_str_copy(Void*, Int, Char*, Int) : Int
  fun decode_str_lang_copy = wg_decode_str_lang_copy(Void*, Int, Char*, Int) : Int

  fun encode_xmlliteral = wg_encode_xmlliteral(Void*, Char*, Char*) : Int
  fun decode_xmlliteral_copy = wg_decode_xmlliteral_copy(Void*, Int) : Char*
  fun decode_xmlliteral_xsdtype_copy = wg_decode_xmlliteral_xsdtype_copy(Void*, Int) : Char*

  fun decode_xmlliteral_len = wg_decode_xmlliteral_len(Void*, Int) : Int
  fun decode_xmlliteral_xsdtype_len = wg_decode_xmlliteral_xsdtype_len(Void*, Int) : Int
  fun decode_xmlliteral = wg_decode_xmlliteral(Void*, Int, Char*, Int) : Int
  fun decode_xmlliteral_xsdtype = wg_decode_xmlliteral_xsdtype(Void*, Int, Char*, Int) : Int

  fun encode_uri = wg_encode_uri(Void*, Char*, Char*) : Int
  fun decode_uri = wg_decode_uri(Void*, Int) : Char*
  fun decode_uri_prefix = wg_decode_uri_prefix(Void*, Int) : Char*

  fun decode_uri_len = wg_decode_uri_len(Void*, Int) : Int
  fun decode_uri_prefix_len = wg_decode_uri_prefix_len(Void*, Int) : Int
  fun decode_uri_copy = wg_decode_uri_copy(Void*, Int, Char*, Int) : Int
  fun decode_uri_prefix_copy = wg_decode_uri_prefix_copy(Void*, Int, Char*, Int) : Int

  fun encode_blob = wg_encode_blob(Void*, Char*, Char*, Int) : Int
  fun decode_blob = wg_decode_blob(Void*, Int) : Char*
  fun decode_blob_type = wg_decode_blob_type(Void*, Int) : Char*
  fun decode_blob_len = wg_decode_blob_len(Void*, Int) : Int
  fun decode_blob_copy = wg_decode_blob_copy(Void*, Int, Char*, Int) : Int
  fun decode_blob_type_len = wg_decode_blob_type_len(Void*, Int) : Int
  fun decode_blob_type_copy = wg_decode_blob_type_copy(Void*, Int, Char*, Int) : Int


  fun encode_var = wg_encode_var(Void*, Int) : Int
  fun decode_var = wg_decode_var(Void*, Int) : Int

  
  fun dump = wg_dump(Void*, Char*) : Int
  fun import = wg_import(Void*, Char*) : Int
  
  fun start_logging = wg_start_logging(Void*) : Int
  fun stop_logging = wg_stop_logging(Void*) : Int
  fun replay_log = wg_replay_log(Void*) : Int


  fun start_write = wg_start_write(Void*) : Int # Start write transaction
  fun end_write = wg_end_write(Void*) : Int # End write transaction
  fun start_read = wg_start_read(Void*, Int) : Int # Start read transaction
  fun end_read = wg_end_read(Void*, Int) : Int # End read transaction
  
  fun update_atomic_field = wg_update_atomic_field(Void*, Void*, Int, Int, Int) : Int
  fun set_atomic_field = wg_set_atomic_field(Void*, Void*, Int, Int) : Int
  fun add_int_atomic_field = wg_add_int_atomic_field(Void*, Void*, Int, Int) : Int
  

  fun parse_json_file = wg_parse_json_file(Void*, Char) : Int
  fun parse_json_document = wg_parse_json_document(Void*, Char*, Void**) : Int
  fun parse_json_fragment = wg_parse_json_fragment(Void*, Char*, Void**) : Int
  
  fun print_db = wg_print_db(Void*) : Void
  fun print_record = wg_print_record(Void*, Int*) : Void
  fun snprint_value = wg_snprint_value(Void*, Int*) : Void
  fun parse_and_encode = wg_parse_and_encode(Void*, Char*) : Void

  # ...

  # Simplyfied query functions
  fun find_record = wg_find_record(db : Void*, fieldnr : Int, cond : Int, data : Int, lastrecord : Void*) : Void*
  fun find_record_null = wg_find_record_null(db : Void*, fieldnr : Int, cond : Int, data : String, lastrecord : Void*) : Void*
  fun find_record_record = wg_find_record_record(db : Void*, fieldnr : Int, cond : Int, data : Void*, lastrecord : Void*) : Void*
  fun find_record_char = wg_find_record_char(db : Void*, fieldnr : Int, cond : Int, data : Char, lastrecord : Void*) : Void*
  fun find_record_fixpoint = wg_find_record_fixpoint(db : Void*, fieldnr : Int, cond : Int, data : Double, lastrecord : Void*) : Void*
  fun find_record_date = wg_find_record_date(db : Void*, fieldnr : Int, cond : Int, data : Int, lastrecord : Void*) : Void*
  fun find_record_time = wg_find_record_time(db : Void*, fieldnr : Int, cond : Int, data : Int, lastrecord : Void*) : Void*
  fun find_record_var = wg_find_record_var(db : Void*, fieldnr : Int, cond : Int, data : Int, lastrecord : Void*) : Void*
  fun find_record_int = wg_find_record_int(db : Void*, fieldnr : Int, cond : Int, data : Int, lastrecord : Void*) : Void*
  fun find_record_double = wg_find_record_double(db : Void*, fieldnr : Int, cond : Int, data : Double, lastrecord : Void*) : Void*
  fun find_record_str = wg_find_record_str(db : Void*, fieldnr : Int, cond : Int, data : String, lastrecord : Void*) : Void*
  fun find_record_xmlliteral = wg_find_record_xmlliteral(db : Void*, fieldnr : Int, cond : Int, data : String, xsdtype : String, lastrecord : Void*) : Void*
  fun find_record_uri = wg_find_record_uri(db : Void*, fieldnr : Int, cond : Int, data : String, prefix : String, lastrecord : Void*) : Void*

  # ...
  

  fun database_freesize = wg_database_freesize(db : Void*) : Int
  fun database_size = wg_database_size(db : Void*) : Int

  
  # ...

  # Query "arglist" parameters
  enum COND
    EQUAL     = 1
    NOT_EQUAL = 1 << 1
    LESSTHAN  = 1 << 2
    GREATER   = 1 << 3
    LTEQUAL   = 1 << 4
    GTEQUAL   = 1 << 5 
  end
end
" From https://github.com/ahalbert/vim-gbq-syntax/blob/main/syntax/gbq.vim
" Vim syntax file
" Language:	Google Big Query SQL
" Maintainer:	Armand Halbert
" Repository: https://github.com/ahalbert/vim-gbq-syntax
" License:      Vim

" if exists("b:current_syntax")
"   finish
" endif

syn case ignore

" The SQL reserved words, defined as keywords.

syn keyword sqlSpecial	false null true

syn keyword sqlKeyword	access add as asc begin by case cluster column
syn keyword sqlKeyword	connection constraint continue current default desc data
syn keyword sqlKeyword	else elsif end except exclude export files for from
syn keyword sqlKeyword	function group having if immediate increment
syn keyword sqlKeyword	index into is limit load
syn keyword sqlKeyword	model modify matched no key of 
syn keyword sqlKeyword	partition partitions pivot qualify source synonym table tablesample target
syn keyword sqlKeyword	target then to trigger transaction
syn keyword sqlKeyword	unique values view when 
syn keyword sqlKeyword	where with options order primary range
syn keyword sqlKeyword	recursive references reservation respect restrict repeat return row rows 
syn keyword sqlKeyword	temp temporary unbounded using 
syn keyword sqlKeyword	join cross inner outer left right false 

"GBQ ML Option Keywords
syn keyword sqlKeyword input_label_cols optimize_strategy l1_reg l2_reg max_iterations
syn keyword sqlKeyword learn_rate_strategy learn_rate early_stop min_rel_progress
syn keyword sqlKeyword data_split_method data_split_eval_fraction data_split_col
syn keyword sqlKeyword ls_init_learn_rate warm_start auto_class_weights class_weights
syn keyword sqlKeyword enable_global_explain calculate_p_values fit_intercept category_encoding_method

syn keyword sqlOperator	not and or replace on
syn keyword sqlOperator	in any some all between exists
syn keyword sqlOperator	like escape unnest
syn keyword sqlOperator	union intersect minus
syn keyword sqlOperator	distinct interval
syn keyword sqlOperator	out

syn keyword sqlStatement call delete drop execute grant lock 
syn keyword sqlStatement rename rollback set
syn keyword sqlStatement truncate
" next ones are contained, so folding works.
syn keyword sqlStatement create update alter select insert call contained

" GBQ Data Types
syn keyword sqlType	array bignumeric bool bytes date datetime float64
syn keyword sqlType	geography int64 interval json numeric string struct time timestamp
syn keyword sqlType	microsecond millisecond second minute hour dayofweek
syn keyword sqlType	day dayofyear week isoweek month quarter year isoyear

" Strings:
syn region sqlString	matchgroup=Quote start=+n\?"+     end=+"+
syn region sqlString	matchgroup=Quote start=+n\?"""+     end=+"""+
syn region sqlString	matchgroup=Quote start=+n\?'+     end=+'+
syn region sqlString	matchgroup=Quote start=+n\?`+     end=+`+
syn region sqlString	matchgroup=Quote start=+n\?q'\z([^[(<{]\)+    end=+\z1'+
syn region sqlString	matchgroup=Quote start=+n\?q'<+   end=+>'+
syn region sqlString	matchgroup=Quote start=+n\?q'{+   end=+}'+
syn region sqlString	matchgroup=Quote start=+n\?q'(+   end=+)'+
syn region sqlString	matchgroup=Quote start=+n\?q'\[+  end=+]'+

" Numbers:
syn match sqlNumber	"-\=\<\d*\.\=[0-9_]\>"

" Comments:
syn region sqlComment	start="/\*"  end="\*/" contains=sqlTodo,@Spell fold 
syn match sqlComment	"--.*$" contains=sqlTodo,@Spell

" Setup Folding:
" this is a hack, to get certain statements folded.
" the keywords create/update/alter/select/insert need to
" have contained option.
syn region sqlFold start='^\s*\zs\c\(Create\|Update\|Alter\|Select\|Insert\)' end=';$\|^$' transparent fold contains=ALL

syn sync ccomment sqlComment

" Functions:
" AEAD Encryption Functions
syn keyword sqlFunction	aead decrypt_bytes decrypt_string encrypt deterministic_decrypt_bytes
syn keyword sqlFunction	deterministic_decrypt_string deterministic_encrypt keys.add_key_from_raw_bytes
syn keyword sqlFunction	keys keyset_chain keyset_from_json keyset_length keyset_to_json new_keyset
syn keyword sqlFunction	new_wrapped_keyset rewrap_keyset rotate_keyset rotate_wrapped_keyset
" Aggregate Functions
syn keyword sqlFunction	array_agg any_value array_concat_agg array_concat_agg bit_and bit_or bit_xor count
syn keyword sqlFunction	countif logical_and logical_or max min string_agg sum
" Approximate Aggregate Functions
syn keyword sqlFunction	approx_count_distinct approx_quantiles approx_top_count approx_top_sum
" HLL+ Functions
syn keyword sqlFunction	hll_count init merge_partial merge
" Array Functions
syn keyword sqlFunction	array_concat array_length array_reverse array_to_string generate_array
syn keyword sqlFunction	generate_date_array generate_timestamp_array offset ordinal
" Conversion Functions
syn keyword sqlFunction	cast parse_bignumeric parse_numeric safe_cast
" Date Functions
syn keyword sqlFunction	current_date date date_add date_diff date_from_unix_date date_sub
syn keyword sqlFunction	date_trunc extract format_date last_day parse_date unix_date
" Datetime Functions
syn keyword sqlFunction	current_datetime datetime datetime_add datetime_diff
syn keyword sqlFunction	datetime_sub datetime_trunc extract format_datetime
syn keyword sqlFunction	last_day parse_datetime
" Time Functions
syn keyword sqlFunction	current_time format_time parse_time time_add time_diff time_sub time_trunc
" Datetime Functions
syn keyword sqlFunction	current_timestamp format_timestamp parse_timestamp timestamp_add 
syn keyword sqlFunction	timestamp_diff timestamp_micros timestamp_millis timestamp_seconds
syn keyword sqlFunction	timestamp_sub timestamp_trunc unix_micros unix_millis unix_seconds
" Interval Functions
syn keyword sqlFunction	justify_days justify_hours justify_interval make_interval
" Geography Functions
syn keyword sqlFunction	s2_cellidfrompoint st_angle st_area st_asbinary st_asgeojson
syn keyword sqlFunction	st_astext st_azimuth st_boundary st_boundingbox st_buffer
syn keyword sqlFunction	st_bufferwithtolerance st_centroid_agg st_centroid st_closestpoint
syn keyword sqlFunction	st_clusterdbscan st_contains st_convexhull st_coveredby st_covers
syn keyword sqlFunction	st_difference st_dimension st_disjoint st_distance st_dump
syn keyword sqlFunction	st_dwithin st_endpoint st_extent st_exteriorring st_geogfrom
syn keyword sqlFunction	st_geogfromgeojson st_geogfromtext st_geogfromwkb st_geogpoint
syn keyword sqlFunction	st_geogpointfromgeohash st_geohash st_geometrytype st_interiorrings
syn keyword sqlFunction	st_intersection st_intersects st_intersectsbox st_isclosed 
syn keyword sqlFunction	st_iscollection st_isempty st_isring st_length st_makeline
syn keyword sqlFunction	st_makepolygon st_makepolygonoriented st_maxdistance st_npoints
syn keyword sqlFunction	st_numgeometries st_numpoints st_perimeter st_pointn st_snaptogrid
syn keyword sqlFunction	st_startpoint st_touches st_union_agg st_union st_within st_x st_y
" Hash Functions
syn keyword sqlFunction	farm_fingerprint md5 sha1 sha256 sha512
" JSON Functions
syn keyword sqlFunction	json_extract_array json_extract_scalar json_extract_string_array 
syn keyword sqlFunction	json_extract json_query_array json_query json_type json_value
syn keyword sqlFunction	json_value_array parse_json to_json_string to_json
" Math Functions
syn keyword sqlFunction	abs acos acosh asin asinh atan atan2 atanh cbrt ceil ceiling
syn keyword sqlFunction	cos cosh cot coth csc csch div exp floor greatest ieee_divide
syn keyword sqlFunction	is_inf is_nan least ln log log10 mod pow power rand range_bucket
syn keyword sqlFunction	round safe_add safe_divide safe_multiply safe_negate safe_subtract
syn keyword sqlFunction	sec sech sign sin sinh sqrt tan tanh trunc
" Navigation Functions
syn keyword sqlFunction	first_value lag last_value lead nth_value percentile_cont percentile_disc
" Net Functions
syn keyword sqlFunction	net host ip_from_string ip_net_mask ip_to_string ip_trunc ipv4_from_int64 
syn keyword sqlFunction	ipv4_to_int64 public_suffix reg_domain safe_ip_from_string
" Numbering Functions
syn keyword sqlFunction	cume_dist dense_rank ntile percent_rank rank row_number
" Statistical Aggregate Functions
syn keyword sqlFunction	corr covar_pop covar_samp stddev_pop stddev_samp stddev var_pop var_samp variance
" String Functions
syn keyword sqlFunction	ascii byte_length char_length character_length chr code_points_to_bytes 
syn keyword sqlFunction	code_points_to_string collate concat contains_substr ends_with format
syn keyword sqlFunction	from_base32 from_base64 from_hex initcap instr left length lower lpad
syn keyword sqlFunction	ltrim normalize_and_casefold normalize octet_length regexp_contains 
syn keyword sqlFunction	regexp_extract regexp_instr regexp_replace regexp_substr repeat 
syn keyword sqlFunction	reverse right rpad rtrim safe_convert_bytes_to_string soundex split
syn keyword sqlFunction	starts_with strpos substr substring to_base32 to_base64 to_code_points
syn keyword sqlFunction	to_hex translate trim unicode upper
" Various Functions
syn keyword sqlFunction	bit_count external_object_transform external_query error generate_uuid search
syn keyword sqlFunction	session_user
" Todo:
syn keyword sqlTodo TODO FIXME XXX DEBUG NOTE contained

" Define the default highlighting.
hi def link Quote		Special
hi def link sqlComment		Comment
hi def link sqlFunction		Function
hi def link sqlKeyword		sqlSpecial
hi def link sqlNumber		Number
hi def link sqlOperator		sqlStatement
hi def link sqlSpecial		Special
hi def link sqlStatement	Statement
hi def link sqlString		String
hi def link sqlType		Type
hi def link sqlTodo		Todo
let b:current_syntax = "sql"
" vim: ts=8

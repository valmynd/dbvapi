uses Gee

init
	/* test dicts */
	var d = new dict of string,string

	/* add or change entries with following */
	d["Genie"] = "Great"
	d["Vala"] = "Rocks"
	
	
	/* access entires using d[key] */
	/* note that instead of "d.get_keys ()" it is "d.keys" in newer Versions of Gee */
	for s in d.keys
		print "%s => %s", s, d[s]

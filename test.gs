uses Gee

class Test : Object
	prop d : dict of string,string
	prop l : list of string
	init
		print "init"
		l = new list of string
		d = new dict of string,string
	construct (li : list of string)
		print "construct1"
		for s in li
			l.add(s) // segfaults
	construct from_dict(di : dict of string,string)
		print "construct2"
		for entry in di.entries
			d[entry.key] = entry.value // segfaults

init
	// ARRAY
	var lst = new list of string
	lst.add("one")
	var t = new Test(lst)
	// DICT
	var map = new dict of string,string
	map["four"] = "4"			// same as map.set ("four", 4)
	map["five"] = "5"
	var a = map.get ("four")
	var b = map["four"]			// same as map.get ("four")
	assert (a == b)
	var tt = new Test.from_dict(map)

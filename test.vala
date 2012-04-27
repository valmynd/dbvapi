using Gee;

class Test : Object {
	public HashMap<string, string> d;
	public ArrayList<string> l;
	construct {
		l = new ArrayList<string> ();
		d = new HashMap<string, string> ();
	}
	public Test(ArrayList<string> list) {
		foreach (string s in list)
			l.add(s);
	}
	public Test.from_dict(HashMap<string, string> dict) {
		foreach (var entry in dict.entries)
			d[entry.key] = entry.value;
	}
}

void main () {
	// ARRAY
	var list = new ArrayList<string> ();
	list.add("one");
	var t = new Test(list);
	foreach (string s in t.l)
		stdout.printf ("%s\n", s);
	// DICT
	var map = new HashMap<string, string> ();
	map["four"] = "4";			// same as map.set ("four", 4)
	map["five"] = "5";
	string a = map.get ("four");
	string b = map["four"];		// same as map.get ("four")
	assert (a == b);
	var tt = new Test.from_dict(map);
	foreach (var entry in tt.d.entries)
		stdout.printf ("%s => %s\n", entry.key, entry.value);
}

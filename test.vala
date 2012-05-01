/*using Gee;

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
*/
class Foo : Object {
	public int hello { get; set; }
	public int world { get; set; }
	public int foo_bar { get; set; }

	public signal void action ();
	public signal void more_action ();
}

enum Bar {
	FEE, FIE, FOE, FUM
}

void main () {

	/* Getting type information */
	Type type = typeof (Foo);
	stdout.printf ("%s\n", type.name ());

	/* Instantiation from type */
	Foo foo = (Foo) Object.new (type);

	/* list properties of a class */
	var obj_class = (ObjectClass) typeof (Foo).class_ref ();
	var properties = obj_class.list_properties ();
	foreach (var prop in properties) {
		stdout.printf ("%s\n", prop.name);
	}

	/* enum value as string */
	var enum_class = (EnumClass) typeof (Bar).class_ref ();
	string name = enum_class.get_value (Bar.FEE).value_name;
	stdout.printf ("Enum value as string: %s\n", name);

	/* list signals of a class */
	uint[] ids = Signal.list_ids (typeof (Foo));
	foreach (uint id in ids) {
		stdout.printf ("%s\n", Signal.name (id));
	}
}

class Adress : Object {
	public string street { get; set; default = ""; }
	public string housenr { get; set; default = ""; }
}

int main () {
	var x = new Adress();
	//print("%s\n", Adress.street._name);
	// Adress.street.like("%Avenue)
	// print(oneadressobj.street) would print "Park Avenue"
	//s.get_values();
	// https://live.gnome.org/Vala/ValaForCSharpProgrammers#Reflection
	/*var obj_class = (ObjectClass) typeof(Adress).class_ref();
	var properties = obj_class.list_properties();
	foreach(var prop in properties)
		print("col: %s nick: %s\n", prop.name, prop.get_nick());
	*/return 0;
}

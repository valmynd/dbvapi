/*
Copyright (C) 2012 C.Wilhelm
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

using Gee;
//using Gda;

class Database : Object {
	//public ArrayList<Model> models;
	//public Model user_model;
}

class Column : Operand {
	public string _name;
	construct {
		_name = "cn";
	}
	public Column() {
	}
	public override string to_string() {
		return _name;
	}
}

class Model : Object {
	/* every Model object has one Database object associated with it */
	//public Database db;
	/* access Column names by columns.keys; Column objects by columns.values */
	//public ArrayList<Column> columns;
}

/* Easy interface to GdaSqlBuilder
 * maybe extend to other backends later */
abstract class Command : Object {
	/* every Command object has one (main) Model object associated with it (?) */
	/* a Database object is in place for convenience */
	public Database db;
	/* all subclasses need to be able to be converted into each other
	back and forth, so any information must be avaiable, even if
	irrelevant for current operation */
	public ArrayList<Column> relevant_columns;
	public ArrayList<Column> groupby_columns;
	public ValueArray values_commit;
	public ValueArray values_where;
	public ValueArray values_having;
	construct {
		db = null;
		relevant_columns = new ArrayList<Column>();
		groupby_columns = new ArrayList<Column>();
		values_commit = new ValueArray(0);
		values_where = new ValueArray(0);
		values_having = new ValueArray(0);
	}
	/*public void values_v(ValueArray vals) {
		free(values_commit); // gets replaced!
		values_commit = vals.copy();
	}*/
	/** returns all values related to this command depending on it's type */
	public abstract ValueArray get_values();
}

class Insert : Command {
	// http://www.swig.org/Doc1.3/Varargs.html
	// [GIR (name = "foo")]
	public Insert(ArrayList<Column> into_columns) {
		relevant_columns = into_columns;
	}
	public override ValueArray get_values() {
		return values_commit.copy();
	}
}

class Update : Command {
	public Update(ArrayList<Column> updated_columns) {
		relevant_columns = updated_columns;
	}
	public override ValueArray get_values() {
		// values_commit + values_where # ensure the right order
		var tmp = new ValueArray(values_commit.n_values + values_where.n_values);
		foreach (Value el in values_commit) tmp.append(el);
		foreach (Value el in values_where) tmp.append(el);
		return tmp;
	}
}

class Delete : Command {
	public Delete() {} // Context should get more precise in WHERE clause
	public override ValueArray get_values() {
		return values_where.copy();
	}
}

class Select : Command {
	/*public Select(ArrayList<Column> columns) {
		relevant_columns = columns;
	}*/
	public Select(Column c1, ...) {
		/*var l = va_list();
		while (true) {
			Column? cx = l.arg();
			if (cx == null) break;	// end of varargs
			//print(cx._name);
		};*/
	}
	public override ValueArray get_values() {
		// values_commit + values_having # ensure the right order
		var tmp = new ValueArray(values_where.n_values + values_having.n_values);
		foreach (Value el in values_where) tmp.append(el);
		foreach (Value el in values_having) tmp.append(el);
		return tmp;
	}
}

/*
select().from(MyModel).where(
 	MyModel.age.equals(50).and(
		MyModel.fullname.like("%huber")
 	).or(
		MyModel.pk.equals(1)
	)
)
http://code.google.com/p/sqlheavy/wiki/UserGuide#ORM_Generator */

class Adress : Model {
	public Column street;// { get; set; }
	public Column housenr;// { get; set; }
	construct {
		street = new Column();
		housenr = new Column();
	}
}

class DatabaseInstance : Database {
	construct {
	}
}

int main () {
	test_expressions();
	var x = new Adress();
	var s = new Select(x.street);
	print("%s\n", Adress.street._name);
	// Adress.street.like("%Avenue)
	// print(oneadressobj.street) would print "Park Avenue"
	//s.get_values();
	// \n#line.*\n
	// https://live.gnome.org/Vala/ValaForCSharpProgrammers#Reflection
	var obj_class = (ObjectClass) typeof(Adress).class_ref();
	var properties = obj_class.list_properties();
	foreach(var prop in properties)
		print("col: %s nick: %s\n", prop.name, prop.get_nick());
	return 0;
}

using Gee;
using Gda;

class Database {
	public ArrayList<Model> models;
	public Model user_model;
}

class Column : Object {
	public string name;
	construct {
		name = "";
	}
}

class Model : Object {
	/* every Model object has one Database object associated with it */
	public Database db;
	/* access Column names by columns.keys; Column objects by columns.values */
	public ArrayList<Column> columns;
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
	public void values(ValueArray vals) {
		//values_commit = vals; // replaces them!
	}
	/** returns all values related to this command depending on it's type */
	public abstract ValueArray get_values();
}

class Insert : Command {
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
	public Select(ArrayList<Column> columns) {
		relevant_columns = columns;
	}
	public override ValueArray get_values() {
		// values_commit + values_having # ensure the right order
		var tmp = new ValueArray(values_where.n_values + values_having.n_values);
		foreach (Value el in values_where) tmp.append(el);
		foreach (Value el in values_having) tmp.append(el);
		return tmp;
	}
}

int main () {
	return 0;
}

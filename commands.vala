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
class Command : Object {
	/* every Command object has one (main) Model object associated with it (?) */
	//public model : Model
	/* a Database object is in place for convenience */
	public Database db;
	/* all subclasses need to be able to be converted into each other
	back and forth, so any information must be avaiable, even if
	irrelevant for current operation */
	/*public ArrayList<Column> relevant_columns;
	public ArrayList<Column> groupby_columns;
	public LinkedList<Value> values_commit;
	public LinkedList<Value> values_where;
	public LinkedList<Value> values_having;*/
	/* take list of either String or Colmn objects
	possibilities for strings: 
		tablename.columnname
		columnname // requires "from" clause
		customexpr?? */	
	//construct from_strings(columns : list of string)
	// init//code that pertains to the initlization of the class
	construct {
		//relevant_columns = new ArrayList<Column> ();
		//groupby_columns = new ArrayList<Column> ();
	}
	Command(ArrayList<Column> columns) {
		//relevant_columns = columns;
	}
}

int main () {
	return 0;
}

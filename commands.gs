uses Gee

class Database
	prop models : dict of string,Model
	prop user_model : Model

class Column : Object
	prop name : string

class Model : Object
	/* every Model object has one Database object associated with it */
	prop db : Database
	/* access Column names by columns.keys; Column objects by columns.values */
	prop columns : dict of string,Column

class Command : Object
	/* every Command object has one (main) Model object associated with it (?) */
	//prop model : Model
	/* a Database object is in place for convenience */
	prop db : Database
	/* all subclasses need to be able to be converted into each other
	back and forth, so any information must be avaiable, even if
	irrelevant for current operation */
	prop relevant_columns : dict of string,Column
	prop groupby_columns : dict of string,Column
	prop values_commit : list of string
	prop values_where : list of string
	prop values_having : list of string
	/* take list of either String or Colmn objects */	
	construct (columns : list of Object)
		for c in columns
			if c isa Column
				print "kgj"
			else
				print ((string)c)
	//construct with_bar (bar : int)

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
	/* test Command */
	var cols = new list of Object
	cols.add((Object)"one")
	var c = new Command(cols)

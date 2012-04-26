uses Gee

init
	var l = new list of string
	l.add("abc")    
	l.add("def")
	l.add("xyz")
	if l.contains("mno") == false do print "mno is not in the list"
	if l.contains("xyz") == true do print "xyz is in the list"
	print "Content of field 1: %s", l.get(1)
	l.set(1,"ghi")
	print "Content of field 1: %s", l[1]
	l.insert(1,"mno")
	l.insert(1,"pqr")
	l.remove_at(4) /*removes xyz*/
	l.remove("mno")
	print "Index of 'ghi': %d", l.index_of("ghi")
	l.set(2,"stu") /*changes ghi to stu*/
	for o in l do print o

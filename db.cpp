/*
Copyright (C) 2012 C.Wilhelm
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

#include <iostream>
#include <string>
using namespace std;
 
// http://en.wikipedia.org/wiki/Property_%28programming%29#C.2B.2B
class IntegerColumn {
	private:
		int value;
	public:
		int& operator= (const int &i) {
			return value = i;
		}
		operator int const& () const {
			return value;
		}
};

class StringColumn {
	private:
		string value;
	public:
		string& operator= (const string &i) {
			return value = i;
		}
		operator string const& () const {
			return value;
		}
};
 
class Adress {
	public:
		StringColumn street;
		IntegerColumn houseno;
};
 
int main () {
	Adress x;
	x.street = "Hao";
	x.houseno = 2;
	cout << x.street << x.houseno << endl;
	return 0;
}

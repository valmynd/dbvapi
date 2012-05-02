/*
Copyright (C) 2012 C.Wilhelm
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

#include <iostream>
#include <string>
using namespace std;
 
// http://en.wikipedia.org/wiki/Property_%28programming%29#C.2B.2B
template <typename T> class Column {
	private:
		T value;
	public:
		T & operator = (const T &i) {
			return value = i;
		}
		operator T const & () const {
			return value;
		}
		friend inline ostream &operator<<(ostream &stream, Column const &obj) {
			stream << obj.value;
			return stream;
		}
		friend inline istream &operator>>(istream &stream, Column const &obj) {
			stream >> obj.value;
			return stream;
		}
};
 
struct Bar {
	Column <int> alpha;
	Column <float> bravo;
	Column <string> str;
};
 
int main () { 
	Bar bar;
	bar.alpha = 2;
	bar.bravo = 2.5f;
	bar.str = string("2");
	cout << bar.alpha << "\n" << bar.bravo << "\n" << bar.str << endl;
	return 0;
}

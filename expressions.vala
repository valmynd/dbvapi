/*
Copyright (C) 2012 C.Wilhelm
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

abstract class Operand : Object {
	public abstract string to_string();
	public Expression and(Value right) {
		return new Expression(ExprOperator.AND, this, right);
	}
	public Expression or(Value right) {
		return new Expression(ExprOperator.OR, this, right);
	}
	public Expression equals(Value right) {
		return new Expression(ExprOperator.OR, this, right);
	}
}

class Expression : Operand {
	private ExprOperator _op;
	private Value _left;
	private Value _right;
	public Expression(ExprOperator t, Value left, Value right) {
		_op = t;
		_left = left;
		_right = right;
	}
	public override string to_string() {
		// str(left) + str(_op) + str(right)
		string operand1, operator, operand2;
		if(_left.type().is_a(typeof(Operand)))
			operand1 = ((Operand)_left).to_string();
		else operand1= "?";
		if(_right.type().is_a(typeof(Operand)))
			operand2 = ((Operand)_right).to_string();
		else operand2 = "?";
		try {
			operator = _operator_to_str(_op);
		} catch (InvalidExpression e) {
			operator = "??";
		}
		return string.join(operator, operand1, operand2);
	}
}

/**will get mapped to Gda.SqlOperatorType (do not change(?))*/
public enum ExprOperator {
	AND,
	OR,
	EQ,
	IS,
	LIKE,
	BETWEEN,
	GT,
	LT,
	GEQ,
	LEQ,
	DIFF,
	REGEXP,
	REGEXP_CI,
	NOT_REGEXP,
	NOT_REGEXP_CI,
	SIMILAR,
	ISNULL,
	ISNOTNULL,
	NOT,
	IN,
	NOTIN,
	CONCAT,
	PLUS,
	MINUS,
	STAR,
	DIV,
	REM,
	BITAND,
	BITOR,
	BITNOT,
	ILIKE
}

errordomain InvalidExpression {
    NONEXISTANT_OPERATOR,
    FOO
}

// this function primarily exists for debugging, usually libgda will be used
string _operator_to_str(ExprOperator o) throws InvalidExpression {
	switch (o) {
	case ExprOperator.AND: return " and ";
	case ExprOperator.OR: return " or ";
	case ExprOperator.EQ: return " = ";
	case ExprOperator.IS: return " is ";
	case ExprOperator.LIKE: return " like ";
	case ExprOperator.BETWEEN: return " between ";
	case ExprOperator.GT: return " > ";
	case ExprOperator.LT: return " < ";
	case ExprOperator.GEQ: return " >= ";
	case ExprOperator.LEQ: return " <= ";
	case ExprOperator.DIFF: return "??";
	case ExprOperator.REGEXP: return "??";
	case ExprOperator.REGEXP_CI: return "??";
	case ExprOperator.NOT_REGEXP: return "??";
	case ExprOperator.NOT_REGEXP_CI: return "??";
	case ExprOperator.SIMILAR: return " similar to ";
	case ExprOperator.ISNULL: return " is null ";
	case ExprOperator.ISNOTNULL: return " is not null ";
	case ExprOperator.NOT: return " not ";
	case ExprOperator.IN: return " in ";
	case ExprOperator.NOTIN: return " not in ";
	case ExprOperator.CONCAT: return "??";
	case ExprOperator.PLUS: return " + ";
	case ExprOperator.MINUS: return " - ";
	case ExprOperator.STAR: return "??";
	case ExprOperator.DIV: return "??";
	case ExprOperator.REM: return "??";
	case ExprOperator.BITAND: return "??";
	case ExprOperator.BITOR: return "??";
	case ExprOperator.BITNOT: return "??";
	case ExprOperator.ILIKE: return " ilike ";
	default:
		throw new InvalidExpression.NONEXISTANT_OPERATOR("nyan");
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
=> Operate on Column objects instead of strings containing their names
=> Accept Value, Column, Expression objects as Operands
=> https://live.gnome.org/Vala/ValueSample
plan: dependency on libgda only if relational backend is used, native impl. shouldn't need to have libgda
read https://live.gnome.org/Vala/Tutorial#Methods_With_Syntax_Support
read http://developer.gimp.org/api/2.0/app/app-config-interface.html
class Column : Operand {
	public override string to_string() {
		return "Hallo";
	}
}
int main () {
	var x = new Column();
	var y = new Column();
	var z = x.and(y);
	var a = new Expression(ExprOperator.EQ, "as", "yahoo");
	var b = new Expression(ExprOperator.EQ, a, z);
	//Value v = b;
	//print("%s\n", v.type().name());
	if(a is Expression)
		print("%s\n", b.to_string());
	return 0;
}
*/

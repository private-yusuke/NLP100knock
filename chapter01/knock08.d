import std;

string cipher(string s) {
	import std.ascii : isAlpha, isLower;

	return s.map!(i => (i.isAlpha && i.isLower) ? (219 - i).to!char : i)
		.array
		.to!string;
}

void main() {
	cipher("This is a test").writeln;
	// cipher関数の逆関数はcipherである。
	cipher("This is a test").cipher.writeln;
}

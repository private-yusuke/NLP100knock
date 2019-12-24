import std;

const string s = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics.";

dchar[][] disassemble(string str) {
	return str.filter!(i => !['.', ','].any!(k => i == k)).array.split;
}

void main() {
	disassemble(s).each!(i => writefln("%s %d", i, i.length));
}

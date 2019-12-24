import std;

void main() {
	string res;
	zip("パトカー", "タクシー").map!(i => format("%s%s", i[0], i[1])).join.writeln;
}

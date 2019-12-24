import std;

void main() {
	auto arr = slurp!(string, string, float, string)("hightemp.txt", "%s\t%s\t%f\t%s");
	string col1 = arr.map!(i => i[0]).join('\n');
	string col2 = arr.map!(i => i[1]).join('\n');

	import std.file : write;

	write("col1.txt", col1);
	write("col2.txt", col2);

	// $ cut -d \t -f 1 hightemp.txt
	// $ cut -d \t -f 2 hightemp.txt
}

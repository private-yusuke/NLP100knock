import std;

void main() {
	slurp!(string, string, float, string)("hightemp.txt", "%s\t%s\t%f\t%s").map!(i => i[0])
		.array
		.sort
		.group
		.array
		.sort!"a[1] > b[1]"
		.map!(i => format("%s %d", i[0], i[1]))
		.each!writeln;
	// $ cut -d \t -f 1 hightemp.txt | sort | uniq -c | sort -r
}

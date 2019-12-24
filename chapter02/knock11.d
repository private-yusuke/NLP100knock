import std;

void main() {
	readText("hightemp.txt").map!(i => i == '\t' ? ' ' : i).writeln;

	// $ cat hightemp.txt | tr '\t' ' '
	// $ sed -e "s/"\t"/ /g" hightemp.txt
	// $ expand -t 1 hightemp.txt
}

import std;

void main(string[] args) {
	File("hightemp.txt", "r").byLine.take(args[1].to!size_t).each!writeln;
	// $ head -n 3 hightemp.txt
}

import std;

void main() {
    slurp!(string, string, float, string)("hightemp.txt", "%s\t%s\t%f\t%s").map!(i => i[0]).array.sort.uniq.writeln;

    // $ cut -d \t -f 1 hightemp.txt | sort | uniq
}
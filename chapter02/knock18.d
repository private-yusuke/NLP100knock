import std;

void main() {
    readText("hightemp.txt").chomp.split('\n')
    .map!(i => i.split('\t'))
    .array.sort!((a, b) => a[2].to!float < b[2].to!float)
    .map!(i => i.join('\t'))
    .join('\n').writeln;

    // $ sort hightemp.txt
}
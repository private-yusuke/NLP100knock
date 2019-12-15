import std;

void main() {
    File("hightemp.txt", "r").byLine.count.writeln;
    // $ wc -l hightemp.txt
    //       24 hightemp.txt
}
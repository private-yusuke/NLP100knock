import std;

void main(string[] args) {
    // File.byLine は bidirectionalRange ではないので、retroできない……
    // したがって下記のようにした。
    readText("hightemp.txt").chomp.split('\n').retro.take(args[1].to!size_t).each!writeln;
    // $ tail -n 3 hightemp.txt
}
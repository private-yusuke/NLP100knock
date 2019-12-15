import std;

void main() {
    auto col1 = readText("col1.txt").split;
    auto col2 = readText("col2.txt").split;

    auto res = zip(col1, col2).map!(i => format("%s\t%s", i[0], i[1]));
    write("col1-col2-merged.txt", res);

    // $ paste col1.txt col2.txt
}
import std;

string f(uint x, string y, double z) {
    return format("%d時の%sは%f", x, y, z);
}
void main() {
    f(12, "気温", 22.4).writeln;
}
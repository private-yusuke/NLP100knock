import std;

void main() {
    "パタトクカシーー".enumerate.filter!(i => i.index % 2 == 0).map!(i => i.value).writeln;
}
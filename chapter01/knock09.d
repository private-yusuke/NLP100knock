import std;

const string s = "I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind .";

dstring[] disassemble(string str) {
    return str.filter!(i =>
        !['.', ','].any!(k => i == k)
    ).array.split.to!(dstring[]);
}

auto typoglycemia(string str) {
    return str.disassemble.map!(i =>
        i.length <= 4 ? i : i.front ~ i[1..$-1].to!(dchar[]).randomShuffle(rndGen()) ~ i.back
    ).array;
}

void main() {
    s.typoglycemia.join(" ").writeln;
}
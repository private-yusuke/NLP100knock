import std;
const string s = "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can.";

dstring[] disassemble(string str) {
    return str.filter!(i =>
        !['.', ','].any!(k => i == k)
    ).array.split.to!(dstring[]);
}

void main() {
    auto set = [1, 5, 6, 7, 8, 9, 15, 16, 19];
    auto dis = disassemble(s);
    dstring[ulong] arr;

    foreach(i, v; dis) {
        if(set.canFind(i+1)) {
            arr[i+1] = dis[i][0..1];
        } else {
            arr[i+1] = dis[i][0..2];
        }
    }
    arr.writeln;
}
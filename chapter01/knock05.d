import std;

// なんもわからん！あきらめる
auto ngram(Range)(Range r, ulong n) if(isInputRange!(Unqual!Range) {
    in {
        assert(n >= 1, "n must be more than 0.");
    } do {
        static struct Result {
            private alias R = Unqual!Range;
            public R source;
            private size_t _n;

        }
    }
}
void main() {
    
}
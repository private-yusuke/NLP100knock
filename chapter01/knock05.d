import std;

const string s = "I am an NLPer";

dstring[] disassemble(string str) {
    return str.filter!(i =>
        !['.', ','].any!(k => i == k)
    ).array.split.to!(dstring[]);
}

// 参考にしました
// https://furutsuki.hatenablog.com/entry/2018/02/01/233840

auto ngram(Range)(Range r, ulong n = 2) if (isInputRange!(Unqual!Range)) {
    assert(n >= 1);

    // InputRange として考える。
    // empty, popFront, front を持っていればよい

    static struct Result {
        private alias R = Unqual!Range;
        private size_t n;
        private size_t k;

        public R source;
        this(R source, size_t n) {
            this.source = source;
            this.n = n;
        }

        @property {
            bool empty() {
                return this.k + this.n - 1 >= this.source.length;
            }
            auto ref front() {
                return this.source[k..k+n];
            }
        }

        void popFront() {
            this.k++;
        }
    }
    return Result(r, n);
}

void main() {
    disassemble(s).ngram.writeln;
    ngram(s).writeln;

    // おまけ
    writeln(">>> おまけ <<<");

    static struct FibonacciRange {
        private long n = 1, m = 1;
        @property {
            enum empty = false;
            long front() const {
                return n;
            }
        }
        void popFront() {
            auto t = n;
            n = m;
            m = t + m;
        }
    }

    FibonacciRange fib;
    fib.take(10).writeln;
    fib.take(10).drop(5).writeln;
}
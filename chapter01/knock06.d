import std;

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
				return this.source[k .. k + n];
			}
		}

		void popFront() {
			this.k++;
		}
	}

	return Result(r, n);
}

void main() {
	auto X = ngram("paraparaparadise").array.sort.uniq.array;
	auto Y = ngram("paragraph").array.sort.uniq.array;

	writefln("X or Y: %s", multiwayUnion([X, Y]));
	writefln("X and Y: %s", setIntersection(X, Y));
	writefln("X - Y: %s", X.setDifference(Y));
	writefln("Y - X: %s", Y.setDifference(X));
	writefln("'se' in X?: %s", X.canFind("se"));
	writefln("'se' in Y?: %s", Y.canFind("se"));
}

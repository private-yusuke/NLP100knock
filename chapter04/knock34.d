import std;

// neko.txt.mecab は、Homebrewでインストールしたときについてくる標準の辞書を利用しています。
// neologdとかだと「我輩は猫である」が一つの名詞として解釈されてしまい、これは良いんですが、
// もしかしたら狙いとは違う分類になってしまうのかもしれないので。

// 表層形\t品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用型,活用形,原形,読み,発音
/*
 * 表層形(surface), 基本形(base), 品詞(pos), 品詞細分解(pos1)
*/
string[string][][] readNeko() {
	string[string][][] res;
	string[string][] tmp;
	foreach (line; File("neko.txt.mecab", "r").byLine) {
		if (line == "EOS") {
			if (tmp != null)
				res ~= tmp;
			tmp = null;
			continue;
		}
		auto cols = line.split('\t').to!(string[]);
		if (cols.length < 2)
			continue;
		auto rcol = cols[1].split(',').to!(string[]);

		string[string] morpheme;
		morpheme["surface"] = cols[0];
		morpheme["base"] = rcol[6];
		morpheme["pos"] = rcol[0];
		morpheme["pos1"] = rcol[1];
		tmp ~= morpheme;
	}
	return res;
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
	auto neko = readNeko();
	string[] res;
	foreach (line; neko) {
		auto arr = ngram(line, 3);
		foreach (v; arr) {
			if (v[0]["pos"] == "名詞" && v[2]["pos"] == "名詞" && v[1]["surface"] == "の")
				res ~= format("%sの%s", v[0]["surface"], v[2]["surface"]);
		}
	}

	res.writeln;

	// せっかくなので以前作ったngram関数を利用しました。
}

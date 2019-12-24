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

void main() {
	auto neko = readNeko();
	ulong[string] counter;
	foreach (line; neko) {
		foreach (morpheme; line) {
			counter[morpheme["surface"]] += 1;
		}
	}
	foreach (p; zip(counter.keys, counter.values).sort!((a, b) => a[1] > b[1]).take(10)) {
		writefln("%s %d", p[0], p[1]);
	}

	// $ rdmd knock37.d > knock37_out.txt
	// $ gnuplot knock37_plot.g
}

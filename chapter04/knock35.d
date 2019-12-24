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
	string[] res;
	foreach (line; neko) {
		string tmp;
		ulong cnt = 0;

		foreach (morpheme; line) {
			if (morpheme["pos"] == "名詞") {
				tmp ~= morpheme["surface"];
				cnt++;
			} else {
				if (cnt >= 2)
					res ~= tmp;
				cnt = 0;
				tmp = "";
			}
		}

		if (cnt >= 2)
			res ~= tmp;
	}
	res.writeln;
}

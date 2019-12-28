import std;

class Morph {
    string surface, base, pos, pos1;
    this(string surface, string base, string pos, string pos1) {
        this.surface = surface;
        this.base = base;
        this.pos = pos;
        this.pos1 = pos1;
    }
    override string toString() {
        return format("surface: [%s], base: [%s], pos: [%s], pos1: [%s]",
            this.surface, this.base, this.pos, this.pos1);
    }
}
// neko.txt.cabocha は、Homebrewでインストールしたときについてくる標準の辞書を利用しています。
// neologdとかだと「我輩は猫である」が一つの名詞として解釈されてしまい、これは良いんですが、
// もしかしたら狙いとは違う分類になってしまうのかもしれないので。

// 表層形\t品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用型,活用形,原形,読み,発音
/*
 * 表層形(surface), 基本形(base), 品詞(pos), 品詞細分解(pos1)
*/
Morph[][] readNeko() {
	Morph[][] res;
	Morph[] tmp;
	foreach (line; File("neko.txt.cabocha", "r").byLine) {
		if (line == "EOS") {
				res ~= tmp;
			tmp = null;
			continue;
		}
        // 係り受け解析の結果はスキップします
        if(line.startsWith('*')) continue;
		auto cols = line.split('\t').to!(string[]);
		if (cols.length < 2)
			continue;
		auto rcol = cols[1].split(',').to!(string[]);

		auto morpheme = new Morph(cols[0], rcol[6], rcol[0], rcol[1]);
		tmp ~= morpheme;
	}
	return res;
}

void main() {
	readNeko()[2].each!writeln;

    // MeCab用に書いたパーサー(knock30)が実質的にそのまま使い回せる！！
}

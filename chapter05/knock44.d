module chapter05.knock42;

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
		return format("surface: [%s], base: [%s], pos: [%s], pos1: [%s]", this.surface, this.base, this.pos, this.pos1);
	}
}

/*
 * "* 文節番号 係り先の文節番号(係り先なし:-1) 主辞の形態素番号/機能語の形態素番号 係り関係のスコア(大きい方が係りやすい)"
 * https://qiita.com/nezuq/items/f481f07fc0576b38e81d より
 * 係り際文節インデックス番号(dst), 係り元文節インデックス番号のリスト(srcs)
*/
class Chunk {
	Morph[] morphs;
	long dst;
	long[] srcs;

	override string toString() {
		return format("%s srcs[%(%d,%)] dst[%d]", this.morphs.map!(i => i.surface).join.array, this.srcs, this.dst);
	}

	string surfacesToString() {
		string res;
		foreach (morph; this.morphs) {
			if (morph.pos != "記号")
				res ~= morph.surface;
		}
		return res.to!string;
	}
}

// 表層形\t品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用型,活用形,原形,読み,発音
/*
 * 表層形(surface), 基本形(base), 品詞(pos), 品詞細分解(pos1)
*/
Chunk[][] parseSentence(string sentence) {
	Chunk[][] res; // key: idx
	Morph[] morphs;
	long index; // 現在の文節番号
	Chunk[ulong] current;
	auto cabocha_res = executeShell(format("echo \"%s\" | cabocha -f1", sentence)).output;
	foreach (line; cabocha_res.split('\n')) {
		if (line == "EOS") {
			res ~= current.keys.sort.map!(i => current[i]).array;
			current = null;
		} else if (line.startsWith('*')) {
			auto cols = line.split(' ').to!(string[]);
			index = cols[1].to!long;
			if (!(index in current))
				current[index] = new Chunk;
			const auto dst = cols[2][0 .. $ - 1].to!long;
			current[index].dst = dst;
			if (dst != -1) {
				if (!(dst in current))
					current[dst] = new Chunk;
				current[dst].srcs ~= index;
			}
		} else {
			auto cols = line.split('\t').to!(string[]);
			if (cols.length < 2)
				continue;
			auto rcol = cols[1].split(',').to!(string[]);

			auto morph = new Morph(cols[0], rcol[6], rcol[0], rcol[1]);
			current[index].morphs ~= morph;
		}
	}
	return res;
}

void main() {
	auto input = readln.chomp;
	auto chunks = parseSentence(input);

	string res;
	res ~= "digraph parsed {\n";
	foreach (index, chunk; chunks[0]) {
		if (chunk.dst != -1) {
			string src = chunk.surfacesToString();
			string dst = chunks[0][chunk.dst].surfacesToString();
			res ~= format("    %s%d [label=\"%s\"];\n", src, index, src);
			res ~= format("    %s%d [label=\"%s\"];\n", dst, chunk.dst, dst);
			res ~= format("    %s%d -> %s%d;\n", src, index, dst, chunk.dst);
		}
	}
	res ~= "}";
	res.writeln;
}

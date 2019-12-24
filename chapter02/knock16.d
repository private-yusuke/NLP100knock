import std;

// 1分割 -> 元のファイルのまま
// 2分割 -> 全体を2つに分ける
// 3分割 -> 全体を3つに分ける
// ......

void main(string[] args) {
	auto N = args[1].to!int;
	auto content = readText("hightemp.txt").chomp.split('\n');
	auto lineCount = content.length;

	auto k = (lineCount + N) / N;
	foreach (i; 0 .. N) {
		import std.file : write;

		write(format("%d-%d.txt", N, i + 1), content[i * k .. min((i + 1) * k, lineCount)].join('\n'));
	}

	// split -l 6 hightemp.txt test
}

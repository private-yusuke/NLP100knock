import std;

JSONValue[] getJson() {
	auto uc = new UnCompress;

	string content;
	foreach (chunk; File("jawiki-country.json.gz").byChunk(1024)) {
		auto unc = uc.uncompress(chunk);
		content ~= cast(string) unc;
	}
	content ~= cast(string) uc.flush();

	return content.chomp.split('\n').map!(i => parseJSON(i)).array;
}

string UK() {
	return getJson().filter!(i => i["title"].str == "イギリス").array[0]["text"].str;
}

void main() {
	string uk = UK();
	auto reg1 = ctRegex!(r"^\{\{基礎情報.*?$(.*?)^\}\}$", "gms");
	auto basicinfos = uk.matchAll(reg1).array[0][1];
	auto reg2 = ctRegex!(r"\|(.+?) = (.+?)(?:(?=\n\|)|(?=\|$))", "gms");
	string[string] m;
	foreach (v; basicinfos.matchAll(reg2)) {
		m[v[1]] = v[2];
	}
	m.each!((i, v) => writefln("%s: %s", i, v));
}

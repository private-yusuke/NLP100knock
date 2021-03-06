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
	auto reg = ctRegex!(r".*\[\[Category:.*\]\]");
	uk.matchAll(reg).map!(i => i[0])
		.each!writeln;
}

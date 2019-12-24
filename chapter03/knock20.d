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

void main() {
	auto json = getJson();
	foreach (v; json) {
		if (v["title"].str == "イギリス")
			writeln(v["text"].str);
	}
}

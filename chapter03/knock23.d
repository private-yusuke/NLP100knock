import std;

JSONValue[] getJson() {
    auto uc = new UnCompress;

    string content;
    foreach(chunk; File("jawiki-country.json.gz").byChunk(1024)) {
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
    auto reg = ctRegex!(r"(={2,})\s*(.+?)\1.*");
    uk.matchAll(reg).map!(i => format("%(\t%)%d %s", iota(i[1].length - 2), i[1].length - 1, i[2])).each!writeln;
}
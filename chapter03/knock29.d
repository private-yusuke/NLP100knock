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

string extractBasicInfo(string s) {
    auto r = ctRegex!(r"^\{\{基礎情報.*?$(.*?)^\}\}$", "gms");
    return s.matchAll(r).array[0][1];
}

string removeSign(string s) {
    auto r = ctRegex!(r"('{2,5})(.+?)(\1)", "gms");
    string removeSignFun(Captures!string c) {
        return c[2];
    }
    return replaceAll!(removeSignFun)(s, r);
}

string removeBracketsAttribute(string s) {
    auto r = ctRegex!(r"\[\[(.+?)\]\]");
    string removeInternalLinkFun(Captures!string c) {
        return c[1];
    }
    return replaceAll!(removeInternalLinkFun)(s, r);
}

string removeTags(string s) {
    auto r = ctRegex!(r"<\/?(?:br|ref).*?(?:\s\/)?>");
    return replaceAll(s, r, "");
}

string removeLangs(string s) {
    auto r = ctRegex!(r"\{\{lang\|.*?\|([^\|]*)\}\}");
    return replaceAll(s, r, "$1");
}

string[string] mapBasicInfo(string s) {
    auto r = ctRegex!(r"\|(.+?) = (.+?)(?:(?=\n\|)|(?=\|$))", "gms");
    string[string] m;
    foreach(v; s.matchAll(r)) {
        m[v[1]] = v[2];
    }
    return m;
}


void main() {
    string uk = UK();
    auto basicinfo = extractBasicInfo(uk)
        .removeSign.removeBracketsAttribute.removeTags
        .removeLangs;
    
    auto m = mapBasicInfo(basicinfo);

    auto filename = m["国旗画像"];
    auto imageinfo = "https://www.mediawiki.org/w/api.php?action=query&format=json&prop=imageinfo&titles=File:%s&iiprop=url"
        .format(filename.map!(i => i == ' ' ? '_' : i).array).get.parseJSON;

    imageinfo["query"]["pages"]["-1"]["imageinfo"][0]["url"].str.writeln;
}
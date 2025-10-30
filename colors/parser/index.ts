import * as fs from "fs";

const colorsFile = fs.readFileSync("colors.scss").toString();
const colors: { [key: string]: string } = {};

colorsFile.split("\n").forEach((line) => {
    if (line.startsWith("//")) return;

    const split = line.split(":");
    const name = (split[0] || "").replace("$", "").trim();
    const hex = (split[1] || "").replace(";", "").replace("#", "").trim();

    if (!hex || !name) return;

    colors[hex] = name;
    // colors[name] = hex;
})

const themeFile = fs.readFileSync("after-dark.json").toString().split("\n");
const linesChanged: number[] = [];

for (let i = 0; i < themeFile.length; i++) {
    const line = themeFile[i]!;
    for (const key of Object.keys(colors)) {
        if (line.search(key) !== -1) {
            // console.log(line.search(key))
            themeFile[i] = line.replaceAll(key, colors[key]!);
            linesChanged.push(i);
        }
    }
}

fs.writeFileSync("after-dark-new.json", themeFile.join("\n"));
console.log(linesChanged);

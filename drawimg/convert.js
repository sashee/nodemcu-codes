var fs = require("fs");

new Promise((res, rej) => {
fs.readdir(".", (err, files) => {
	if(err){
		rej(err);
	}
	res(files.filter((e) => e.endsWith(".bitmap")));
});
}).then((files) => {
files.forEach((file) => {
fs.readFile(file, "utf8", function(err, data) {
    if(err){
	return console.log(err);
    }

    var points = data.split("{")[1].split("}")[0].split(",").map(function(a){
         return a.split("x")[1].trim();
    }).join("");
var buf = new Buffer(points, "hex");
var buf2 = buf.map(function(num) {
b0 = (num & 0x1) << 7;
b1 = (num & 0x2) << 5;
b2 = (num & 0x4) << 3;
b3 = (num & 0x8) << 1;
b4 = (num & 0x10) >> 1;
b5 = (num & 0x20) >> 3;
b6 = (num & 0x40) >> 5;
b7 = (num & 0x80) >> 7;
var res = b0 + b1 + b2 + b3 + b4 + b5 + b6 + b7;
return res;
});
	var r = fs.createWriteStream(file.replace(".bitmap",".bm"));
	r.write(buf2);
	r.end();
});
});
});

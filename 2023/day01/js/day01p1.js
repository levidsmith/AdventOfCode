//2023 Levi D. Smith
const fs = require('node:fs');

strInputFile = "../input01.txt";

var strContents = fs.readFileSync(strInputFile).toString();
var strLines = strContents.split("\n");

var iSum = 0;
var iLine = 0;
while (iLine < strLines.length) {
	var iFirst = null;
	var iLast = null;
	
	iDigitStart = "0".charCodeAt(0);
	iDigitEnd = "9".charCodeAt(0);
	
	for (i = 0; i < strLines[iLine].length; i++) {
		c = strLines[iLine].charCodeAt(i);
		if (c >= iDigitStart && c <= iDigitEnd) {
			if (iFirst == null) {
				iFirst = c - iDigitStart;
			}
			iLast = c - iDigitStart;
		}
	}
	
	iValue = (iFirst * 10) + iLast;
	iSum += iValue;
	iLine += 1;
}

console.log(iSum)

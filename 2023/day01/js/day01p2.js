//2023 Levi D. Smith



function main() {
	const fs = require('node:fs');
	strInputFile = "../input01.txt";
	var strContents = fs.readFileSync(strInputFile).toString();
	var strLines = strContents.split("\n");

	const digitNames = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
	
	var iSum = 0;
	var iLine = 0;
	while (iLine < strLines.length) {
		var strLine = strLines[iLine];
		
		if (strLine == "") {
			iLine += 1;
			continue;
		}
		
		iDigits = [];
		
		iDigitStart = "0".charCodeAt(0);
		iDigitEnd = "9".charCodeAt(0);
		
		for (i = 0; i < strLine.length; i++) {
			for (j = 0; j < digitNames.length; j++) {
				if (strLine.substring(i, i + digitNames[j].length) == digitNames[j]) {
					iDigits.push(getDigitValue(digitNames[j]));
				}
			}
			
			if (strLine.charCodeAt(i) >= iDigitStart && strLine.charCodeAt(i) <= iDigitEnd) {
				iDigits.push(strLine.charCodeAt(i) - iDigitStart);
			}
		}
		
//		console.log(strLine + " > " + iDigits);
		
		iValue = (iDigits[0] * 10) + iDigits[iDigits.length - 1];
//		console.log("iValue: " + iValue);
		iSum += iValue;

		iLine += 1;

	}
	

	console.log(iSum)
}

function getDigitValue(strDigit) {
	switch(strDigit) {
		case "one":
			return 1;
		case "two":
			return 2;
		case "three":
			return 3;
		case "four":
			return 4;
		case "five":
			return 5;
		case "six":
			return 6;
		case "seven":
			return 7;
		case "eight":
			return 8;
		case "nine":
			return 9;
	}
}

main();

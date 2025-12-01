//2025 Levi D. Smith
import java.io.*;

public class Day01P1 {
  public static void main(String[] args) {

    try {
      BufferedReader br = new BufferedReader(new FileReader("../input01.txt"));
      String strLine;

      while ((strLine = br.readLine()) != null) {

        int iValue = 0;
//        System.out.println("line: " + strLine);
	int i;
	char[] chars = strLine.toCharArray();
	for (i = 0; i < chars.length; i++) {
          switch(chars[i]) {
            case '(':
              iValue++;
	      break;
	    case ')':
	      iValue--;
	      break;
          }
	}
        System.out.println(String.valueOf(iValue));
      }
      br.close();
    } catch (IOException e) {
      System.out.println("File Not Found");
    }

  }
}

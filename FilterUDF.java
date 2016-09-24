package myUDF;

import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;

public class FilterUDF extends UDF {
	private Text result = new Text();

	public Boolean evaluate(String fName, String lName) {

		String firstName = (String) fName;
		String lastName = (String) lName;
		if (firstName.toLowerCase().charAt(0) == lastName.toLowerCase().charAt(0)) {
			result.set(firstName + "," + lastName);
			return true;
		} else {
			return false;
		}

	}
}

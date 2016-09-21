package MyPackage;

import java.io.IOException;
import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;

public class ValidateNames extends EvalFunc<Boolean> {

	@Override
	public Boolean exec(Tuple input) throws IOException {
		// TODO Auto-generated method stub
		if (input.size() < 2) {
			return null;
		} else {
			Object fName = input.get(0);
			Object SName = input.get(1);
			String firstName = (String) fName;
			String secondName = (String) SName;
			if (firstName.toLowerCase().charAt(0) == secondName.toLowerCase().charAt(0)) {
				return true;
			} else {
				return false;
			}
		}

	}

}

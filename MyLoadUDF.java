package MyPackage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.InputFormat;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.RecordReader;
import org.apache.pig.LoadFunc;
import org.apache.pig.PigException;
import org.apache.pig.backend.executionengine.ExecException;
import org.apache.pig.backend.hadoop.executionengine.mapReduceLayer.PigSplit;
import org.apache.pig.data.DataByteArray;
import org.apache.pig.data.Tuple;
import org.apache.pig.data.TupleFactory;

public class MyLoadUDF extends LoadFunc {

	private String loadLocation;
	private boolean[] requiredFields = null;
	private boolean requiredFieldsInitialized = false;
	protected RecordReader reader = null;
	private Tuple tuple;
	private static byte fieldDel = '\n';
	private TupleFactory tupleFactory = TupleFactory.getInstance();
	ArrayList<Object> protoTuple = null;

	@Override
	public InputFormat getInputFormat() throws IOException {
		// TODO Auto-generated method stub
		return new TextInputFormat();
	}

	@Override
	public Tuple getNext() throws IOException {
		// TODO Auto-generated method stub
		try {

			ArrayList<Object> listTuples = new ArrayList<Object>();

			for (int k = 0; k < 4; k++) {
				protoTuple = new ArrayList<Object>();
				if (!reader.nextKeyValue()) {
					return null;
				}
				Text value = (Text) reader.getCurrentValue();
				byte[] buf = value.getBytes();
				int len = value.getLength();
				int start = 0;
				int fieldID = 0;

				for (int i = 0; i < len; i++) {
					if (buf[i] == fieldDel) {
						if (requiredFields == null || (requiredFields.length > fieldID && requiredFields[fieldID]))
							readField(buf, start, i, protoTuple);
						start = i + 1;
						fieldID++;
					}
				}
				// pick up the last field
				if (start <= len
						&& (requiredFields == null || (requiredFields.length > fieldID && requiredFields[fieldID]))) {
					readField(buf, start, len, protoTuple);
				}
				listTuples.add(protoTuple);
			}
			return tupleFactory.newTuple(listTuples.toString());
		} catch (InterruptedException e) {
			int errCode = 6018;
			String errMsg = "Error while reading input";
			throw new ExecException(errMsg, errCode, PigException.REMOTE_ENVIRONMENT, e);
		}
	}

	// Initializes LoadFunc for reading data.
	@Override
	public void prepareToRead(RecordReader recordReader, PigSplit pigSplit) throws IOException {
		// TODO Auto-generated method stub
		reader = recordReader;
	}

	// Communicate to the loader the location of the object(s) being loaded.
	@Override
	public void setLocation(String location, Job job) throws IOException {
		FileInputFormat.setInputPaths(job, location);
	}

	private void readField(byte[] buf, int start, int end, List protoTuple) {
		if (start == end) {
			// NULL value
			protoTuple.add(null);
		} else {
			protoTuple.add(new DataByteArray(buf, start, end));
		}
	}

}

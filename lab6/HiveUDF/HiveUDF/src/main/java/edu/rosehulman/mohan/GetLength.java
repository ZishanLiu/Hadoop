package edu.rosehulman.mohan;

import org.apache.hadoop.hive.ql.exec.UDFArgumentException;
import org.apache.hadoop.hive.ql.metadata.HiveException;
import org.apache.hadoop.hive.ql.udf.generic.GenericUDF;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.PrimitiveObjectInspectorFactory;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.StringObjectInspector;
import org.apache.hadoop.io.IntWritable;

public class GetLength extends GenericUDF {

    StringObjectInspector input;

       public ObjectInspector initialize(ObjectInspector[] objectInspectors) throws UDFArgumentException {

        if (objectInspectors.length != 1) {
            throw new UDFArgumentException(" Need just one argument for GetLength Function");
        }
        ObjectInspector arg = objectInspectors[0];
        if(! (arg instanceof StringObjectInspector)){
            throw new UDFArgumentException("Argument must be of type String");
        }
        this.input =  (StringObjectInspector) arg;
        return PrimitiveObjectInspectorFactory.writableIntObjectInspector;
    }


    public Object evaluate(DeferredObject[] deferredObjects) throws HiveException {
       if(deferredObjects.length!=1)
        return null;

       Object inputArgument = deferredObjects[0].get();
       String inputValue = this.input.getPrimitiveJavaObject(inputArgument);
       return new IntWritable(inputValue.length());
    }

    public String getDisplayString(String[] strings) {
        return "This function returns the length of the passed String";
    }
}
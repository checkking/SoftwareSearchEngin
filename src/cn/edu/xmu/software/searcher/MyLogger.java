package cn.edu.xmu.software.searcher;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MyLogger {
	final static String logdir = "logs";
	
	public static void log(String str){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String dateStr = sdf.format(new Date());
		String logfile = logdir+"/"+dateStr+".click";
		FileWriter writer = null;
		try {
			writer = new FileWriter(logfile,true);
			writer.write(str);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
				writer.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
}

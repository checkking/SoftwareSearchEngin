package cn.edu.xmu.software.searcher;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

public class ClickLoggerServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String ip = req.getRemoteAddr();
		String query = (String) req.getParameter("q");
		String pos = (String) req.getParameter("pos");
		String url = (String) req.getParameter("url");
		MyLogger.log(Long.toString(System.currentTimeMillis())+"\t"+ip+"\t"+query+"\tclick\t"+url+"\t"+pos+"\n");
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		
	}
	
	

}

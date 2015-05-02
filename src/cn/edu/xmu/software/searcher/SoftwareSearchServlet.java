package cn.edu.xmu.software.searcher;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.client.solrj.impl.HttpSolrServer;

public class SoftwareSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static String BASE_URL = "http://localhost:8080/SoftwareSearchEngine";
	private static HttpSolrServer server;
	
	static{
		server = new HttpSolrServer(BASE_URL);
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/xml");
		try 
		{
			SolrQuery query = new SolrQuery();
			query.set("q", request.getParameter("q"));
			QueryResponse res = server.query(query);		    
			Map<String, Map<String, List<String>>> map = res.getHighlighting();
			
			List<WebSolrDocument> documents = null;
			
			documents = res.getBeans(WebSolrDocument.class);
			
			for (WebSolrDocument doc : documents) 
			{
				Map<String, List<String>> submap = map.get(doc.getId());
				if(submap != null && !submap.isEmpty()&& submap.get("title")!=null && !submap.get("title").isEmpty()) {
					doc.setTitle(submap.get("title").get(0));
				}
				if(submap != null && !submap.isEmpty() &&null !=submap.get("content") && !submap.get("content").isEmpty()) {
					doc.setContent(submap.get("content").get(0));
				}
			}
			
			request.setAttribute("q", request.getParameter("q"));
			request.setAttribute("numFound", res.getResults().getNumFound());
			request.setAttribute("qTime", res.getQTime());
			request.setAttribute("list", documents);
		} 
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		request.getRequestDispatcher("/result.jsp").forward(request, response);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
	}

}

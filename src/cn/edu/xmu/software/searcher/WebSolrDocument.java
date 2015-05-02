package cn.edu.xmu.software.searcher;

import org.apache.solr.client.solrj.beans.Field;

public class WebSolrDocument {
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	@Field("id")
	private String id;
	@Field("title")
	private String title;
	@Field("content")
	private String content;
	@Field("url")
	private String url;
	
	
}

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>${q } - Solr</title>
	</head>
	<body>
		<div style="margin-left:30px">
			<div class="searchdiv">
				<form action="${pageContext.request.contextPath }/q">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="right">
								<input name="q" class="q" size="60" value="${param.q }" />
							</td>
							<td align="left">
								<input type="submit" value="查&nbsp;&nbsp;询" class="btn" />
							</td>
						</tr>
						<tr>
							<td colspan="2"
								style="font-size: 13px; color: green; padding-top: 10px;">
								获得约
								<fmt:formatNumber value="${numFound}" pattern="#,###"></fmt:formatNumber>
								条结果 用时
								<fmt:formatNumber value="${qTime/1000}" pattern="#.##"></fmt:formatNumber>
								秒
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="list" style="width:600px">
				<c:forEach items="${list}" var="item">
				    <p>
				    <a href="${item.url}" target="_blank">${item.title }</a><br />
				    <span>${item.content }</span><br />
				    <span>${item.url }</span><br />
				    </p>
				</c:forEach>
				<div class="pager">
					更多数据:
					<!--<c:forEach begin="0" end="${numFound}" step="10" varStatus="statu">
					<span class="pager"> 
						<c:if test="${statu.index == param.start}" var="pvar"><fmt:formatNumber pattern="#" value="${statu.index/10 + 1}"></fmt:formatNumber></c:if> 
						<c:if test="${not pvar}">
							<a href="${pageContext.request.contextPath }/q?q=${param.q }&start=${statu.index }">
								<fmt:formatNumber pattern="#" value="${statu.index/10 + 1}" />
							</a>
						</c:if> 
					</span>
				</c:forEach>
				-->
					<%
						int pagesize = 10; //每页显示记录数
						int liststep = 14;//最多显示分页页数
						int pages = 1; //默认显示第一页
						int start = 0;
						int numFound = 4;
						if (request.getParameter("start") != null)
							start = Integer.parseInt(request.getParameter("start"));
						if (request.getAttribute("numFound") != null)
							numFound =  Integer.parseInt(request.getAttribute("numFound").toString());
						pages = start / 10 + 1;
						int count = numFound;
						int pagescount = (count - 1) / pagesize + 1;
						if (pages > pagescount)
							pages = pagescount;
						if (pages < 1)
							pages = 1;
						int listbegin = pages - liststep / 2;
						if (listbegin < 1)
							listbegin = 1;
						System.out.println(listbegin);
						int listend = pages + liststep / 2;
						if (listend > pagescount)
							listend = pagescount;
						int recordbegin = (pages - 1) * pagesize;
						int recordend = recordbegin + pagesize;
						if (pages == pagesize)
						{
							recordend = recordbegin + count % pagesize;
						}
						System.out.println(pages);
						System.out.println(pagescount);
						%>
						<c:set var="pages" value="<%=pages-1 %>"></c:set>
						<c:set var="pagesize" value="<%=pagesize %>"></c:set>
						<c:set var="listbegin" value="<%=listbegin %>"></c:set>
						<c:set var="listend" value="<%=listend %>"></c:set>
						<c:set var="pagescount" value="<%=pagescount %>"></c:set>
	
						<c:if test="${pages>0}">
						<a href="${pageContext.request.contextPath }/q?q=${param.q }&start=${(pages-1)*pagesize }">上一页</a>
						</c:if>
				
						<c:forEach begin="${listbegin}" end="${listend}" varStatus="status">
						    <c:choose>
						      <c:when test="${status.index!=pages+1}">
						       <a href="${pageContext.request.contextPath }/q?q=${param.q }&start=${pagesize*(status.index-1) }">[${status.index}]</a>
						      </c:when>
						      <c:otherwise>
						        [${status.index }]
						      </c:otherwise>
						    </c:choose>
						</c:forEach>
						<c:if test="${pages+1<pagescount}">
						    <a href="${pageContext.request.contextPath }/q?q=${param.q }&start=${(pages+1)*pagesize }">下一页</a>
						</c:if>
				</div>
				<form action="${pageContext.request.contextPath }/q">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td align="right">
								<input name="q" class="q" size="60" value="${param.q }" />
							</td>
							<td align="left">
								<input type="submit" value="查&nbsp;&nbsp;询" class="btn" />
							</td>
						</tr>
					</table>
				</form>
				<div class="copyRight">
					<p>
						版权所有 &copy; CHECKKING 2015
					</p>
				</div>
			</div>
		</div>
	</body>
</html>
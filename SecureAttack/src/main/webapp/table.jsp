<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="data.DataBean" %>
<%@ page import="java.util.ArrayList" %>

<%			
	ArrayList<DataBean> dataList = (ArrayList<DataBean>)request.getAttribute("dataList");
	String year = "2020";
	if (request.getParameter("year") != null) {
		year = request.getParameter("year");
	}
%>

<!-- 공격 국가별 횟수 테이블 -->
<table>
	<tr>
		<th>순위</th>
		<th>공격국가</th>
		<th>횟수</th>
	</tr>
<%
	for (int i = 0; i < dataList.size(); i++) {
		DataBean data = dataList.get(i);
%>
	<tr>
		<td><%=i + 1%></td>
		<td><%=data.getcName()%></td>
<%
	if (year.equals("2018")) {
%>
		<td><%=data.getcNum2018()%></td>
<% 
	} else if (year.equals("2019")) {
%>
		<td><%=data.getcNum2019()%></td>
<%
	} else {
%>
		<td><%=data.getcNum2020()%></td>
<%
	}
%>
	</tr>
<%
	}
%>
</table>
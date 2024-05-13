<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="data.DataBean2" %>
<%@ page import="java.util.ArrayList" %>

<%			
	ArrayList<DataBean2> dataList2 = (ArrayList<DataBean2>)request.getAttribute("dataList2");
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
	for (int i = 0; i < dataList2.size(); i++) {
		DataBean2 data2 = dataList2.get(i);
%>
	<tr>
		<td><%=i + 1%></td>
		<td><%=data2.getcName()%></td>
<%
	if (year.equals("2018")) {
%>
		<td><%=data2.getcNum2019()%></td>
<% 
	} else if (year.equals("2019")) {
%>
		<td><%=data2.getcNum2019()%></td>
<%
	} else {
%>
		<td><%=data2.getcNum2020()%></td>
<%
	}
%>
	</tr>
<%
	}
%>
</table>
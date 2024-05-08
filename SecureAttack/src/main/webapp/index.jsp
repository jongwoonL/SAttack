<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="data.jsp" %>

<table border="1">
	<tr>
		<th>공격국가</th>
		<th>수</th>
	</tr>
<%
	 for (int i = 0; i < dataList2.size(); i++) {
		 DataBean2 data2 = dataList2.get(i);
%>
	<tr>
		<td><%=data2.getcName()%></td>
		<td><%=data2.getCNum() %></td>
	</tr>
<%
	}
%>
</table>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="data.DBBean"%>
<%@ page import="data.DataBean"%>
<%@ page import="data.DataBean2"%>
<%@ page import="java.util.*"%>

<%
	List<DataBean> dataList = null;
	List<DataBean2> dataList2 = null;
	DBBean dataProcess = DBBean.getInstance();
	dataList = dataProcess.getDatas();
	dataList2 = dataProcess.getDatas2();
%>
<table border="1">
	<tr>
		<th>공격국가</th>
		<th>trans_ip</th>
	</tr>
<%
	 for (int i = 0; i < dataList.size(); i++) {
		 DataBean data = dataList.get(i);
%>
	<tr>
		<td><%=data.getcName()%></td>
		<td><%=data.getTrans_ip() %></td>
	</tr>
<%
	}
%>
</table>
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
		<td><%=data2.getCount() %></td>
	</tr>
<%
	}
%>
</table>
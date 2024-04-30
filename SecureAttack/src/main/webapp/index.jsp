<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="data.DBBean"%>
<%@ page import="data.DataBean"%>
<%@ page import="java.util.List"%>

<%
	List<DataBean> dataList = null;
	DBBean dataProcess = DBBean.getInstance();
	dataList = dataProcess.getDatas();
%>
<table border="1">
	<tr>
		<th>trans_ip</th>
	</tr>
<%
	 for (int i = 0; i < dataList.size(); i++) {
		 DataBean data = dataList.get(i);
%>
	<tr>
		<td><%=data.getTrans_ip() %></td>
	</tr>
<%
	 }
%>
</table>
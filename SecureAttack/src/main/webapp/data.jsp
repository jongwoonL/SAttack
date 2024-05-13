<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="data.DBBean"%>
<%@ page import="data.DataBean"%>
<%@ page import="java.util.*"%>

<link rel="stylesheet" href="styles.css">

<%
	// 데이터베이스로부터 데이터를 가져오기
	List<DataBean> dataList = null;
	DBBean dataProcess = DBBean.getInstance();
	dataList = dataProcess.getDatas();
	
    // dataList를 request 객체에 설정하여 다른 JSP 파일로 전달
    request.setAttribute("dataList", dataList);
%>

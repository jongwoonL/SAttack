<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="data.jsp" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css">

<%
String year = "2020";
if (request.getParameter("year") != null) {
    year = request.getParameter("year");
}
request.setAttribute("year", year);
%>

<style>
    .chart-container {
        max-height: 550px;
        overflow-y: auto;
    }
</style>

<header class="bg-white py-4 flex items-center justify-center px-4">
    <div class="flex items-center">
        <img class="h-12 mr-2" src="images/logo.png" alt="Logo">
        <h1 class="text-2xl font-bold text-black">악성 IP 기반 국가별 국내 유입 현황</h1>
    </div>
    <nav class="flex space-x-4">
        <a href="main.jsp?year=2018"><button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">2018</button></a>
        <a href="main.jsp?year=2019"><button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">2019</button></a>
        <a href="main.jsp?year=2020"><button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">2020</button></a>
    </nav>
</header>

<main class="container mx-auto my-8 grid grid-cols-2 gap-8">
    <div>
        <h2 class="text-xl font-bold mb-4">전체 악성 IP 기반 국가별 국내 유입 현황</h2>
        <div class="bg-gray-200 p-4 mb-8 chart-container w-full">
            <jsp:include page="bar.jsp"/>
        </div>

        <h2 class="text-xl font-bold mb-4"><%=year%>년 악성 IP 기반 국가별 국내 유입 현황(TOP 10)</h2>
        <div class="bg-gray-200 p-4 chart-container w-full">
            <jsp:include page="treemap.jsp">
                <jsp:param name="year" value="<%= year %>" />
            </jsp:include>
        </div>
    </div>

    <div>
        <h2 class="text-xl font-bold mb-4"><%=year%>년 악성 IP 기반 국가별 국내 유입 현황</h2>
        <div class="bg-gray-200 p-4 mb-8 chart-container w-full">
            <jsp:include page="map.jsp"/>
        </div>

        <h2 class="text-xl font-bold mb-4"><%=year%>년 악성 IP 기반 국가별 국내 유입 현황</h2>
        <div class="bg-gray-200 p-4 chart-container w-full">
            <jsp:include page="table.jsp"/>
        </div>
    </div>
</main>

<footer class="bg-gray-800 py-4 text-center text-white">
    &copy; 2023 Your Company
</footer>


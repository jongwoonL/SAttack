<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.DataBean2" %>
<%@ page import="java.util.ArrayList" %>

<script src="https://d3js.org/d3.v7.min.js"></script>

<style>
    .bar-container {
        overflow-y: auto;
        max-height: 550px;
    }
</style>

<div class="bar-container">
    <svg class="bar" id="bar" width="1000" height="800"></svg>
</div>

<%			
	ArrayList<DataBean2> dataList2 = (ArrayList<DataBean2>)request.getAttribute("dataList2");
%>

<script>
    // JavaScript 데이터 정의
    var data = [
        <% int index = 0;
           for (int i = 0; i < dataList2.size(); i++) {
               DataBean2 data2 = dataList2.get(i);
        %>
            {
                "cName": "<%=data2.getcName()%>",
                "cNum": <%=data2.getcNum()%>,
            },
        <%}%>
    ];

    // 데이터를 정렬
    data.sort(function(a, b) {
        return a.cNum - b.cNum;
    });

    // SVG 요소 크기 설정
    var svgWidth = 1000;
    var svgHeight = 3000;

    // 여백 설정
    var margin = { top: 20, right: 20, bottom: 30, left: 80 };
    var width = svgWidth - margin.left - margin.right;
    var height = svgHeight - margin.top - margin.bottom;

    // SVG 요소 생성
    var svg = d3.select("#bar")
                .attr("width", svgWidth)
                .attr("height", svgHeight);

    // x 축 스케일 설정
    var x = d3.scaleLinear()
              .domain([0, d3.max(data, function(d) { return d.cNum; })])
              .range([0, width]);

    // y 축 스케일 설정
    var y = d3.scaleBand()
              .domain(data.map(function(d) { return d.cName; }))
              .range([height, 0]) // 범위를 반전하여 막대가 위에서부터 시작하도록 함
              .padding(0.1);

    // x 축 생성
    svg.append("g")
       .attr("transform", "translate(" + margin.left + "," + (height + margin.top) + ")")
       .call(d3.axisBottom(x));

    // y 축 생성
    svg.append("g")
       .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
       .call(d3.axisLeft(y));

    // 막대 그래프 생성
    svg.selectAll(".bar")
       .data(data)
       .enter().append("rect")
       .attr("class", "bar")
       .attr("x", margin.left) // 여백을 고려하여 막대의 위치 설정
       .attr("y", function(d) { return y(d.cName) + 30; }) // 막대 그래프의 y 좌표 설정
       .attr("width", function(d) { return x(d.cNum); })
       .attr("height", y.bandwidth() - 20) // 막대 그래프의 높이 설정
       .attr("fill", "steelblue");
</script>

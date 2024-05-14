<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="data.DataBean" %>
<%@ page import="java.util.ArrayList" %>

<!-- D3.js 로드 -->
<script src="https://d3js.org/d3.v7.min.js"></script>

<style>
    .viz-container {
        overflow-y: auto;
        max-height: 550px;
    }
</style>

<!-- 그래프 그리기 영역 -->
<div class="viz_container">
	<svg id="viz_container" width="1000" height="7030"></svg>
</div>


<%
    ArrayList<DataBean> dataList = (ArrayList<DataBean>)request.getAttribute("dataList");
%>

<script>
//JavaScript 데이터 정의
var data = [
    <% for (DataBean data : dataList) { %>
        {
            "cName": "<%=data.getcName()%>",
            "cNum2018": <%=data.getcNum2018()%>,
            "cNum2019": <%=data.getcNum2019()%>,
            "cNum2020": <%=data.getcNum2020()%>
        },
    <% } %>
];

// SVG 요소 크기 설정
var containerWidth = document.getElementById('viz_container').clientWidth;
var svgWidth = containerWidth * 0.9; // SVG 요소의 너비를 최대한 화면에 맞게 조절
var svgHeight = Math.max(data.length * 80 + 100, 200); // 데이터 크기에 따라 동적으로 높이 조절

// 여백 설정
var margin = { top: 100, right: 80, bottom: 30, left: 80 }; // 여백
var width = svgWidth - margin.left - margin.right; // 넓이
var height = svgHeight - margin.top - margin.bottom; // 높이

// SVG 요소 생성
var svg = d3.select("#viz_container")
    .append("svg")
    .attr("width", svgWidth)
    .attr("height", svgHeight)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// x축 눈금 설정 (로그 스케일 적용)
var xScale = d3.scaleLog()  // 로그 스케일 적용
    .domain([1, d3.max(data, function(d) { return Math.max(d.cNum2018, d.cNum2019, d.cNum2020); })])  // 최소값을 1로 설정하여 0값이 있는 경우에도 표시되도록 함
    .range([0, width]);
svg.append('g')
    .attr("transform", "translate(0, "+ height +")")
    .call(d3.axisBottom(xScale).tickSize(0).ticks(5).tickPadding(6).tickFormat(d3.format(".1s")))
    .call(g => g.select(".domain").remove());

// y축 눈금 설정
var yScale = d3.scaleBand()
    .domain(data.map(function (d) { return d.cName; }))
    .range([0, height])
    .padding(.2);
svg.append('g')
    .call(d3.axisLeft(yScale).tickSize(0).tickPadding(8));

// 색상 설정
var color = d3.scaleOrdinal()
    .domain(["cNum2018", "cNum2019", "cNum2020"])
    .range(['#0044BC', '#0072BC','#8EBEFF']);

// 그래프 그리기
bars = svg.selectAll(".bar-group")
    .data(data)
    .enter().append("g")
    .attr("class", "bar-group")
    .attr("transform", function(d) { return "translate(0," + yScale(d.cName) + ")"; });

bars.append("rect")
    .attr("class", "bar-2018")
    .attr("x", function(d) { return 0; })
    .attr("y", function(d) { return 0; })  // y 위치 조정
    .attr("width", function(d) { return xScale(d.cNum2018); })
    .attr("height", function(d) { return yScale.bandwidth() / 3; }) // 높이 조정
    .attr("fill", function(d) { return color("cNum2018"); });

bars.append("rect")
    .attr("class", "bar-2019")
    .attr("x", function(d) { return 0; })
    .attr("y", function(d) { return yScale.bandwidth() / 3; }) // y 위치 조정
    .attr("width", function(d) { return xScale(d.cNum2019); })
    .attr("height", function(d) { return yScale.bandwidth() / 3; }) // 높이 조정
    .attr("fill", function(d) { return color("cNum2019"); });

bars.append("rect")
    .attr("class", "bar-2020")
    .attr("x", function(d) { return 0; })
    .attr("y", function(d) { return 2 * yScale.bandwidth() / 3; }) // y 위치 조정
    .attr("width", function(d) { return xScale(d.cNum2020); })
    .attr("height", function(d) { return yScale.bandwidth() / 3; }) // 높이 조정
    .attr("fill", function(d) { return color("cNum2020"); });

bars.append("text")
    .attr("class", "bar-text")
    .attr("x", function(d) { return xScale(d.cNum2018) + 5; })
    .attr("y", function(d) { return yScale.bandwidth() / 6; }) // cNum2018 그래프 위에 표시
    .attr("dy", ".35em")
    .style("font-size", "15px")
    .text(function(d) { return d.cNum2018; });

bars.append("text")
    .attr("class", "bar-text")
    .attr("x", function(d) { return xScale(d.cNum2019) + 5; })
    .attr("y", function(d) { return yScale.bandwidth() / 2; }) // cNum2019 그래프 위에 표시
    .attr("dy", ".35em")
    .style("font-size", "15px")
    .text(function(d) { return d.cNum2019; });

bars.append("text")
    .attr("class", "bar-text")
    .attr("x", function(d) { return xScale(d.cNum2020) + 5; })
    .attr("y", function(d) { return 5 * yScale.bandwidth() / 6; }) // cNum2020 그래프 아래에 표시
    .attr("dy", ".35em")
    .style("font-size", "15px")
    .text(function(d) { return d.cNum2020; });

// set title
svg.append("text")
    .attr("class", "chart-title")
    .attr("x", -(margin.left) * 0.7)
    .attr("y", -(margin.top) / 1.5 + 10)
    .attr("text-anchor", "start")
    .text("악성IP 국가별 국내 침입 현황 | 2018-2020");

// set legend
svg.append("rect")
    .attr("x", -(margin.left) * 0.7)
    .attr("y", -(margin.top / 2) + 20)
    .attr("width", 10)
    .attr("height", 10)
    .style("fill", "#0072BC");
svg.append("text")
    .attr("class", "legend")
    .attr("x", -(margin.left) * 0.7 + 20)
    .attr("y", -(margin.top / 2.5) + 20)
    .text("2018");

svg.append("rect")
    .attr("x", -(margin.left) * 0.7 + 80)
    .attr("y", -(margin.top / 2) + 20)
    .attr("width", 10)
    .attr("height", 10)
    .style("fill", "#0072BC");
svg.append("text")
    .attr("class", "legend")
    .attr("x", -(margin.left) * 0.7 + 100)
    .attr("y", -(margin.top / 2.5) + 20)
    .text("2019");

svg.append("rect")
    .attr("x", -(margin.left) * 0.7 + 160)
    .attr("y", -(margin.top / 2) + 20)
    .attr("width", 10)
    .attr("height", 10)
    .style("fill", "#8EBEFF");
svg.append("text")
    .attr("class", "legend")
    .attr("x", -(margin.left) * 0.7 + 180)
    .attr("y", -(margin.top / 2.5) + 20)
    .text("2020");

// 마우스 이벤트에 대한 툴팁 요소 추가
var tooltip = d3.select("body").append("div")
    .attr("class", "tooltip")
    .style("position", "absolute")
    .style("z-index", "10")
    .style("visibility", "hidden")
    .style("background-color", "white")
    .style("border", "solid")
    .style("border-width", "1px")
    .style("border-radius", "5px")
    .style("padding", "10px");

// 마우스 드래그 이벤트를 처리하여 툴팁 업데이트
function handleDrag(event, d) {
    tooltip.style("visibility", "visible")
        .html(d.cName + "<br>2018 : " + d.cNum2018 + "<br>2019 : " + d.cNum2019 + "<br>2020 : " + d.cNum2020)
        .style("left", (event.pageX) + "px")
        .style("top", (event.pageY - 28) + "px");
}

// bars에 마우스 드래그 이벤트 리스너 추가
bars.on("mousemove", handleDrag)
    .on("mouseout", function() {
        tooltip.style("visibility", "hidden");
    });
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.DataBean" %>
<%@ page import="java.util.ArrayList" %>

<script src="https://d3js.org/d3.v4.js"></script>
<script src="https://d3js.org/d3-geo-projection.v2.min.js"></script>
<script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>

<svg class="map" id="map" width="1000" height="800"></svg>

<%			
	ArrayList<DataBean> dataList = (ArrayList<DataBean>)request.getAttribute("dataList");
	String year = "2020";
	if (request.getParameter("year") != null) {
		year = request.getParameter("year");
	}
%>

<!-- 지도 차트 스크립트 -->
<script>
    // JavaScript로 데이터 변환
    var dataList = [
    <% for (DataBean data : dataList) { %>
        {
            homelat: <%= data.getLatitude() %>,
            homelon: <%= data.getLongitude() %>,
            n: <%
                if (year.equals("2018")) {
                    out.print(data.getcNum2018());
                } else if (year.equals("2019")) {
                    out.print(data.getcNum2019());
                } else {
                    out.print(data.getcNum2020());
                }
            %>
        },
    <% } %>
    ];

    // SVG 및 지도를 위한 기본 설정
    var map = d3.select("#map"),
        width = +map.attr("width"),
        height = +map.attr("height");

    // 프로젝션 설정
    var projection = d3.geoMercator()
        .center([0, 20]) // 중심 좌표
        .scale(150) // 확대/축소 레벨
        .translate([width / 2, height / 2]);

    // 경로 생성기
    var path = d3.geoPath().projection(projection);

    // 데이터 및 맵 로드
    d3.json("https://raw.githubusercontent.com/holtzy/D3-graph-gallery/master/DATA/world.geojson", function(error, dataGeo) {
        if (error) throw error;

        // 지도를 그리기
        map.append("g")
            .selectAll("path")
            .data(dataGeo.features)
            .enter()
            .append("path")
            .attr("d", path)
            .attr("fill", "#b8b8b8")
            .attr("stroke", "black")
            .attr("stroke-width", 0.5)
            .attr("opacity", 0.8);

        // 원형 마커 추가
        var colorScale = d3.scaleOrdinal(d3.schemeCategory10);

        map.selectAll("circle")
            .data(dataList)
            .enter()
            .append("circle")
            .attr("cx", function(d) { return projection([d.homelon, d.homelat])[0]; })
            .attr("cy", function(d) { return projection([d.homelon, d.homelat])[1]; })
            .attr("r", function(d) { return Math.sqrt(d.n * 0.1); })
            .style("fill", function(d, i) { return colorScale(i); })
            .attr("stroke", "black")
            .attr("stroke-width", 1)
            .attr("fill-opacity", 0.6);
    });

</script>

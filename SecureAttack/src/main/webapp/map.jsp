<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
            <%
            	if (year.equals("2018")) {
            %>
				n: <%= data.getcNum2018() %> // 데이터에서 국가별 횟수 가져오기
			<%
            	} else if (year.equals("2019")) {
            %>
            	n: <%= data.getcNum2019()*100 %> // 데이터에서 국가별 횟수 가져오기
            <%
            	} else {
            %>
            	n: <%= data.getcNum2020() %> // 데이터에서 국가별 횟수 가져오기
            <%            		
            	}
            %>            
        },
    <% } %>
	];

    // The svg
    var map = d3.select("#map"),
	    width = +map.node().getBoundingClientRect().width,
	    height = +map.node().getBoundingClientRect().height;

    // Map and projection
    var projection = d3.geoMercator()
        .center([0,20])                // 확대할 위치의 GPS
        .scale(150)                    // 확대 수준
        .translate([ width/2, height/2 ]);  // 화면 중앙으로 이동

    // Load geo data and draw map and circles
    d3.queue()
      .defer(d3.json, "https://raw.githubusercontent.com/holtzy/D3-graph-gallery/master/DATA/world.geojson")  // 지도 형태
      .await(ready);

    function ready(error, dataGeo) {
      // Draw the map
      map.append("g")
          .selectAll("path")
          .data(dataGeo.features)
          .enter()
          .append("path")
            .attr("fill", "#b8b8b8")
            .attr("d", d3.geoPath()
                .projection(projection)
            )
          .style("stroke", "none")
          .style("opacity", .3)
	
      // 색상 스케일 정의
		var colorScale = d3.scaleOrdinal(d3.schemeCategory10);    
          
      // Add circles:
      map
        .selectAll("myCircles")
        .data(dataList)
        .enter()
        .append("circle")
          .attr("cx", function(d){ return projection([+d.homelon, +d.homelat])[0] })
          .attr("cy", function(d){ return projection([+d.homelon, +d.homelat])[1] })
          .attr("r", function(d){ return Math.sqrt(d.n * 0.1) }) // 원의 크기 설정
          .style("fill", function(d, i) { return colorScale(i); }) // 10가지 색상 중 하나를 선택하여 적용
          .attr("stroke", "black")
          .attr("stroke-width", 1)
          .attr("fill-opacity", .4)

      // Add title and explanation
      map
        .append("text")
          .attr("text-anchor", "end")
          .style("fill", "black")
          .attr("x", width - 10)
          .attr("y", height - 30)
          .attr("width", 90)
          .html("WHERE SURFERS LIVE")
          .style("font-size", 14)

      // --------------- //
      // ADD LEGEND //
      // --------------- //

      // Add legend: circles
      var valuesToShow = [100,4000,15000]
      var xCircle = 40
      var xLabel = 90
      map
        .selectAll("legend")
        .data(valuesToShow)
        .enter()
        .append("circle")
          .attr("cx", xCircle)
          .attr("cy", function(d){ return height - size(d) } )
          .attr("r", function(d){ return size(d) })
          .style("fill", "none")
          .attr("stroke", "black")

      // Add legend: segments
      map
        .selectAll("legend")
        .data(valuesToShow)
        .enter()
        .append("line")
          .attr('x1', function(d){ return xCircle + size(d) } )
          .attr('x2', xLabel)
          .attr('y1', function(d){ return height - size(d) } )
          .attr('y2', function(d){ return height - size(d) } )
          .attr('stroke', 'black')
          .style('stroke-dasharray', ('2,2'))

      // Add legend: labels
      map
        .selectAll("legend")
        .data(valuesToShow)
        .enter()
        .append("text")
          .attr('x', xLabel)
          .attr('y', function(d){ return height - size(d) } )
          .text( function(d){ return d } )
          .style("font-size", 10)
          .attr('alignment-baseline', 'middle')
    }

</script>
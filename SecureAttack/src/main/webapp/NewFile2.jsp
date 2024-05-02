<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="data.DBBean"%>
<%@ page import="data.DataBean"%>
<%@ page import="data.DataBean2"%>
<%@ page import="java.util.*"%>

<%
    // 데이터베이스로부터 데이터를 가져오기
    List<DataBean> dataList = null;
    List<DataBean2> dataList2 = null;
    DBBean dataProcess = DBBean.getInstance();
    dataList = dataProcess.getDatas();
    dataList2 = dataProcess.getDatas2();
%>

<!-- d3.js와 지오 프로젝션 플러그인을 로드 -->
<script src="https://d3js.org/d3.v4.js"></script>
<script src="https://d3js.org/d3-geo-projection.v2.min.js"></script>
<script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>

<!-- 지도가 그려질 요소를 생성 -->
<svg id="my_Treat_IP" width="1800" height="1040"></svg>

<script>
    // JavaScript로 데이터 변환
    var dataList2 = [
        <% for(DataBean2 data2 : dataList2) { %>
            {
                homelat: <%= data2.getLatitude() %>,
                homelon: <%= data2.getLongitude() %>,
                n: <%= data2.getCount() %> // 데이터에서 국가별 횟수 가져오기	            
            },
        <% } %>
    ];

    // The svg
    var svg = d3.select("svg"),
        width = +svg.attr("width"),
        height = +svg.attr("height");

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
      svg.append("g")
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

      // Add circles:
      svg
        .selectAll("myCircles")
        .data(dataList2)
        .enter()
        .append("circle")
          .attr("cx", function(d){ return projection([+d.homelon, +d.homelat])[0] })
          .attr("cy", function(d){ return projection([+d.homelon, +d.homelat])[1] })
          .attr("r", function(d){ return Math.sqrt(d.n) }) // 원의 크기 설정
          .style("fill", "steelblue") // 원의 색상 설정
          .attr("stroke", "black")
          .attr("stroke-width", 1)
          .attr("fill-opacity", .4)

      // Add title and explanation
      svg
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
      svg
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
      svg
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
      svg
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

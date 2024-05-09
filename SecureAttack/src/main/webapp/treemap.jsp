<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="data.DataBean2" %>
<%@ page import="java.util.ArrayList" %>
	
<script src="https://d3js.org/d3.v7.min.js"></script>

<svg class="treemap" id="treemap" width="1000" height="800"></svg>

<%			
	ArrayList<DataBean2> dataList2 = (ArrayList<DataBean2>)request.getAttribute("dataList2");
%>

<!-- 트리맵 차트 스크립트 -->
<script>
    var data = [
<%		int index = 0;
		for (DataBean2 data2 : dataList2) {%>
            {
                "cName": "<%=data2.getcName()%>",
                "cNum": <%=data2.getcNum2020()%>,
                "index": <%=index++%>
            },
<%
       }
%>
    ];

    var color = d3.scaleOrdinal(d3.schemeCategory10);

    var treemapSvg = d3.select("#treemap");
    var width = treemapSvg.node().getBoundingClientRect().width;
    var height = treemapSvg.node().getBoundingClientRect().height;

    var treemap = d3.treemap()
                    .size([width, height])
                    .padding(1)
                    .round(true);

    var root = d3.hierarchy({children: data})
                .sum(function(d) { return d.cNum; })
                .sort(function(a, b) { return b.height - a.height || b.value - a.value; });

    treemap(root);

    var cell = treemapSvg.selectAll("g")
                .data(root.descendants())
                .enter().append("g")
                .attr("transform", function(d) { return "translate(" + d.x0 + "," + d.y0 + ")"; });

    cell.append("rect")
        .attr("id", function(d) { return d.id; })
        .attr("width", function(d) { return d.x1 - d.x0; })
        .attr("height", function(d) { return d.y1 - d.y0; })
        .attr("fill", function(d) { return color(d.data.index); });

    cell.append("text")
        .attr("x", 3)
        .attr("y", 13)
        .attr("dy", ".35em")
        .text(function(d) { return d.data.cName; });
</script>

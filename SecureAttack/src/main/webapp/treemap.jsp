<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="data.DataBean" %>
<%@ page import="java.util.*" %>
	
<script src="https://d3js.org/d3.v7.min.js"></script>

<svg class="treemap" id="treemap" width="1000" height="800"></svg>

<%	
	ArrayList<DataBean> dataList = (ArrayList<DataBean>)request.getAttribute("dataList");
	String year = "2020";
	if (request.getParameter("year") != null) {
		year = request.getParameter("year");
	}

	//데이터를 cNum 기준으로 내림차순으로 정렬
	Collections.sort(dataList, (o1, o2) -> Integer.compare(o2.getcNum2020(), o1.getcNum2020()));
	
	// 상위 10개의 데이터만 선택
	ArrayList<DataBean> top10DataList = new ArrayList<>();
	for (int i = 0; i < Math.min(dataList.size(), 10); i++) {
	    top10DataList.add(dataList.get(i));
}
%>

<!-- 트리맵 차트 스크립트 -->
<script>
    var data = [
<%		int index = 0;
		for (DataBean data : top10DataList) {%>
            {
                "cName": "<%=data.getcName()%>",
                <% 
                if (year.equals("2018")) {
                %>
                "cNum": <%=data.getcNum2018()%>
                <%
                } else if (year.equals("2019")) {
                %>
                "cNum": <%=data.getcNum2019()%>
                <%
                } else {
               	%>
               	"cNum": <%=data.getcNum2020()%>
               	<%
                }
                %>
                , "index": <%=index++%>
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
    
    cell.append("text")
	    .attr("x", 3)
	    .attr("y", 30)
	    .attr("dy", "0.35em")
	    .style("fill", "white")
	    .text(function(d) { return "(" + d.data.cNum + ")"; });
</script>

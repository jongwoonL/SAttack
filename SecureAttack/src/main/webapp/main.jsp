<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="data.jsp" %>
<link rel="stylesheet" href="styles.css">

<body>
	<div class="container">
		<div class="left-section">
			<div class="left-section-inner1">
				<div class="logo-container">
					<img class="logo" src="images/logo.png" width="150px" />
				</div>
				<div class="title-container">
					<h1>악성 IP 기반 국가별 국내 유입 현황</h1>
				</div>
			</div>
			<div class="left-section-inner2">
				<div class="title-container">
					<h1>악성 IP 기반 국가별 국내 유입 현황</h1>
				</div>
				<jsp:include page="bar.jsp"/>
			</div>
			<div class="left-section-inner3">
				<div class="title-container">
					<h1>악성 IP 기반 국가별 국내 유입 현황</h1>
				</div>
				<div class="treemap-container">
					<jsp:include page="treemap.jsp"/>
				</div>
			</div>
		</div>
		<div class="right-section">
			<div class="right-section-inner1">
				<div class="title-container">
					<h1>악성 IP 기반 국가별 국내 유입 현황</h1>
				</div>
				<div class="map-container">
					<div class="button-container">
						<a href="map.jsp?data=2018"><button>버튼 1</button></a>
						<a href="map.jsp?data=2019"><button>버튼 2</button></a>
						<a href="map.jsp?data=2020"><button>버튼 3</button></a>
					</div>
					<jsp:include page="map.jsp"/>
				</div>
			</div>
			<div class="right-section-inner2">
				<div class="title-container">
					<h1>악성 IP 기반 국가별 국내 유입 현황 TOP3</h1>
				</div>
				<div class="table-container">
					<jsp:include page="table.jsp"/>
				</div>
			</div>
		</div>
	</div>
</body>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:useBean id="bean" class="ca.blackperl.jndi.JndiBean"></jsp:useBean>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<x:parse var="rss">
	<c:import url="http://www.keckobservatory.org/recent/rss/" />
</x:parse>
<!doctype html>
<html>
<head>
<title>My Page</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css">
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
<script
	src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>
</head>
<body>
	<div data-role="page">

		<div data-role="header">
			<h1>
				<x:out select="$rss//title" />
				-
				<%-- 2014-01-08T02:48:00+00:00 --%>
				<fmt:parseDate var="tt" pattern="yyyy-MM-dd'T'HH:mm:ss">
					<x:out select="substring-before($rss//*[name()='dc:date'], '+')" />
				</fmt:parseDate>
				<fmt:formatDate value="${tt }" pattern="yyyy/MM/dd HH:mm:ss" />
			</h1>
			<c:out value="${header['User-Agent'] }"></c:out>
			<ul data-role="listview" data-inset="true" data-filter="true">
				<li><a href="#">Acura</a></li>
				<li><a href="#">Audi</a></li>
				<li><a href="#">BMW</a></li>
				<li><a href="#">Cadillac</a></li>
				<li><a href="#">Ferrari</a></li>
			</ul>
		</div>
		<!-- /header -->

		<div data-role="content">
			<div class="datagrid">
				<table>
					<thead>
						<tr>
							<th>header</th>
							<th>header</th>
							<th>header</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<td colspan="3"><div id="paging">
									<ul>
										<li><a href="#"><span>Previous</span></a></li>
										<li><a href="#" class="active"><span>1</span></a></li>
										<li><a href="#"><span>2</span></a></li>
										<li><a href="#"><span>3</span></a></li>
										<li><a href="#"><span>4</span></a></li>
										<li><a href="#"><span>5</span></a></li>
										<li><a href="#"><span>Next</span></a></li>
									</ul>
								</div>
						</tr>
					</tfoot>
					<tbody>
						<x:forEach select="$rss//item" varStatus="s">
							<c:catch>
								<fmt:parseDate var="d" pattern="EE, dd MMM yyyy HH:mm:ss zz">
									<x:out select="pubDate" />
								</fmt:parseDate>
							</c:catch>
							<c:set var="parity"
								value="${ (s.count % 2 == 0 ) ? 'even' : 'odd' }" />
							<tr class="${parity }">
								<td><fmt:formatDate var="fd" value="${d }"
										pattern="yyyy/MM/dd HH:mm:ss" /> <c:out value="${fd }"
										default="null" /></td>
								<td><a href='<x:out select="link"/>'> <x:out
											select="title" /></a></td>
								<td><p>
										<x:out select="description" />
									</p></td>
							</tr>
						</x:forEach>
					</tbody>
				</table>
			</div>
			<ul>
				<c:forEach var="item" items="${bean.list }">
					<li>${item }</li>
				</c:forEach>
			</ul>
		</div>
		<!-- /content -->

		<div data-role="footer">
			<h4>My Footer</h4>
		</div>
		<!-- /footer -->

	</div>
	<!-- /page -->
</body>
</html>

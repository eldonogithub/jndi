<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:useBean id="bean" class="ca.blackperl.jndi.JndiBean"></jsp:useBean>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:if test="${header['User-Agent'].contains('Mobile') }">
	<c:redirect url="/private/mobile.jsp"/>
</c:if>
<x:parse var="rss">
	<c:import url="http://www.keckobservatory.org/recent/rss/" />
</x:parse>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href='<c:url value="/css/reset.css"/>' />
<link rel="stylesheet" href="<c:url value="/css/text.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/960.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/table.css"/>" />
<style type="text/css">
li {
	background-color: yellow;
}

li>a {
	list-style: circle;
	background-color: fuchsia;
	width: 100%;
	display: block;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><x:out select="$rss//title" /></title>
</head>
<body>
	<div class="container_12">
		<div class="grid_12">
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
			<h2>User Principal - <c:out value="${pageContext.request.userPrincipal.name }"></c:out></h2>
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
								<fmt:parseDate var="d" pattern="yyyy-MM-dd'T'HH:mm:ss">
									<x:out select="$s/name()='dc:date'" />
								</fmt:parseDate>
							</c:catch>
							<c:set var="parity"
								value="${ (s.count % 2 == 0 ) ? 'even' : 'odd' }" />
							<tr class="${parity }">
								<td><fmt:formatDate var="fd" value="${d }"
										pattern="yyyy/MM/dd HH:mm:ss" /> <c:out value="${fd }"
										default="${d }" /></td>
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
	</div>
</body>
</html>
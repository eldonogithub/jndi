<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="bean" class="ca.blackperl.bean.Whois" />
<jsp:setProperty property="*" name="bean" />
<c:set var="formats" value="${bean.formats }" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href='<c:url value="/css/reset.css"/>' />
<link rel="stylesheet" href="<c:url value="/css/text.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/960.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/table.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/whois.css"/>" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Whois Lookup</title>
</head>
<body>
	<div class="container_12">
		<div class="grid_12">
			<h1>Whois Lookup</h1>
			<div id="whoisFormId">
				<form method="post"
					action="<c:url value="/whois.jsp"/>">
					<fieldset>
						<legend>Enter Domain Name</legend>
						<label for="server">Select Server: </label><select name="server">
							<c:forEach var="item" items="${bean.whoisServers }">
								<c:choose>
									<c:when test="${item == bean.server }">
										<option value="${item.key }" selected="selected">${item.value }</option>
									</c:when>
									<c:otherwise>
										<option value="${item.key }">${item.value }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select> <label for="command">Select Command: </label><select
							name="command">
							<c:forEach var="item" items="${bean.commandSet }">
								<c:choose>
									<c:when test="${item == bean.command }">
										<option value="${item.key }" selected="selected">${item.value }</option>
									</c:when>
									<c:otherwise>
										<option value="${item.key }">${item.value }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select> <label for="domainName">Domain Name: </label><input type="text"
							value="<c:out value="${bean.domainName }" />" name="domainName">
						<label for="colour">Blue</label>
					</fieldset>
					<input type="submit" name="method" value="Submit"> <input
						type="submit" name="method" value="Help">
					<ul>
						<c:forEach var="colour" items="${bean.colours }">
							<li><input type="checkbox" name="colour" value="${colour }">${colour }</li>
						</c:forEach>
					</ul>
				</form>
			</div>
			<div>
				Search Results for:
				<c:out value="${bean.sentence }" />
			</div>
			<div class="datagrid">
				<c:forEach var="item" items="${formats }">
					${item }<br>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>
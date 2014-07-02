<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="/jndi/css/style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<div id="wrapper">
	<form method="POST" action="j_security_check">
		<input type="text" name="j_username" value="user"> <input type="password"
			name="j_password" value="user">
			<input type="submit" name="submit" value="Submit">
	</form>
	</div>
</body>
</html>
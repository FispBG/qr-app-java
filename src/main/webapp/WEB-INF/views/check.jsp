<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 08.04.2025
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Проверить статус заявления</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/global.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<a href="/" class="btn btn-secondary">Обратно в меню</a>
<h1>Проверить статус заявления</h1>

<form:form action="check" method="post" modelAttribute="appeal" accept-charset="UTF-8" cssClass="check-status-form">
    <div class="form-group">
        <label for="applicantName">Ваше ФИО:</label>
        <form:input path="applicantName" required="true"/>
    </div>

    <div class="submit-container">
        <button type="submit" class="btn btn-primary">Проверить</button>
    </div>
</form:form>

</body>
</html>

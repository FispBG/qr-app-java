<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 08.04.2025
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Проверить статус заявления</title>
</head>
<body>
<a href="/" class="btn btn-secondary">Обратно в меню</a>
<h1>Проверить статус заявления</h1>
<form:form action="check" method="post" modelAttribute="appeal" accept-charset="UTF-8">
    <div class="form-group">
        <label for="applicantName">Ваше ФИО:</label>
        <form:input path="applicantName" class="form-group" required="true"/>
    </div>
    <button type="submit" class="btn btn-primary">Сохранить</button>
</form:form>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

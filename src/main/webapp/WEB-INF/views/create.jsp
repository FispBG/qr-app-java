<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 03.04.2025
  Time: 23:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Создание обращения</title>
</head>
<body>
    <a href="/" class="btn btn-secondary">Обратно в меню</a>
    <h1>Создание обращения</h1>
    <form:form action="/appeal/save" method="post" modelAttribute="appeal" accept-charset="UTF-8">
        <div class="form-group">
            <label for="applicantName">ФИО заявителя:</label>
            <form:input path="applicantName" class="form-group" required="true"/>
        </div>
        <div class="form-group">
            <label for="managerName">ФИО руководителя:</label>
            <form:input path="managerName" class="form-group" required="true"/>
        </div>
        <div class="form-group">
            <label for="address">Адрес:</label>
            <form:input path="address" class="form-group" required="true"/>
        </div>
        <div class="form-group">
            <label for="topic">Тема:</label>
            <form:input path="topic" class="form-group" required="true"/>
        </div>
        <div class="form-group">
            <label for="content">Содержание обращения:</label>
            <form:input path="content" class="form-group" required="true"/>
        </div>
        <input type="hidden" name="list" value="${list}">
        <button type="submit" class="btn btn-primary">Сохранить</button>
    </form:form>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 07.04.2025
  Time: 22:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Вход сотрудника</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
</head>
<body>
<a href="/" class="btn btn-secondary">Обратно в меню</a>
<div class="login-container">
    <h1>Вход сотрудника</h1>
    <form action="login" method="post" class="login-form">
        <div class="form-group">
            <label for="username">Логин:</label>
            <input type="text" id="username" name="username" required class="login-input">
        </div>
        <div class="form-group">
            <label for="password">Пароль:</label>
            <input type="password" id="password" name="password" required class="login-input">
        </div>
        <button type="submit" class="btn btn-primary login-button">Войти</button>
    </form>
</div>
</body>
</html>
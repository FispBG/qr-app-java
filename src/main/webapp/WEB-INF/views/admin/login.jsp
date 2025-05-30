<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Вход сотрудника</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet"> <%-- Предполагается, что этот CSS существует --%>
</head>
<body>
<a href="${pageContext.request.contextPath}/" class="btn btn-secondary" style="margin:10px; display:inline-block;">Обратно на главную</a>
<div class="login-container">
    <h1>Вход сотрудника</h1>
    <c:if test="${not empty error}">
        <p style="color:red;" class="error-message">${error}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/admin/login" method="post" class="login-form">
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
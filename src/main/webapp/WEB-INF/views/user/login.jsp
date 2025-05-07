<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Вход для граждан</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
</head>
<body>
<a href="${pageContext.request.contextPath}/" class="btn btn-secondary" style="margin:10px; display:inline-block;">Обратно на главную</a>
<div class="login-container">
    <h1>Вход для граждан</h1>
    <c:if test="${not empty error}">
        <p style="color:red;" class="error-message">${error}</p>
    </c:if>
    <c:if test="${not empty param.error and param.error eq 'true'}">
        <p style="color:red;" class="error-message">Неверный email или пароль.</p>
    </c:if>
    <c:if test="${not empty successMessage}">
        <p style="color:green;" class="success-message">${successMessage}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/user/login" method="post" class="login-form">
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="${param.email}" required class="login-input">
        </div>
        <div class="form-group">
            <label for="password">Пароль:</label>
            <input type="password" id="password" name="password" required class="login-input">
        </div>
        <button type="submit" class="btn btn-primary login-button">Войти</button>
    </form>
    <p>Новый пользователь? <a href="${pageContext.request.contextPath}/user/register">Зарегистрироваться</a></p>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Регистрация гражданина</title>
  <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
</head>
<body>
<a href="${pageContext.request.contextPath}/" class="btn btn-secondary" style="margin:10px; display:inline-block;">Обратно на главную</a>
<div class="login-container">
  <h1>Регистрация гражданина</h1>
  <c:if test="${not empty error}">
    <p style="color:red;" class="error-message">${error}</p>
  </c:if>
  <form action="${pageContext.request.contextPath}/user/register" method="post" class="login-form">
    <div class="form-group">
      <label for="fullName">Полное ФИО:</label>
      <input type="text" id="fullName" name="fullName" value="${fullName}" required class="login-input">
    </div>
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" value="${email}" required class="login-input">
    </div>
    <div class="form-group">
      <label for="password">Пароль:</label>
      <input type="password" id="password" name="password" required class="login-input">
    </div>
    <button type="submit" class="btn btn-primary login-button">Зарегистрироваться</button>
  </form>
  <p>Уже есть аккаунт? <a href="${pageContext.request.contextPath}/user/login">Войти</a></p>
</div>
</body>
</html>
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
</head>
<body>
    <a href="/">Вернуться в меню</a>
    <h1>Вход сотрудника</h1>
    <form action="login" method="post">
        <div>
            <label for="username">Логин:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <label for="password">Пароль:</label>
            <input type="text" id="password" name="password" required>
        </div>
        <button type="submit">Войти</button>
    </form>
</body>
</html>

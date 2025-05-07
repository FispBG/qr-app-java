<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Система Обращений Граждан</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; color: #333; }
        .navbar { background-color: #333; overflow: hidden; padding: 10px 20px; }
        .navbar a { float: left; display: block; color: white; text-align: center; padding: 14px 16px; text-decoration: none; }
        .navbar a:hover { background-color: #ddd; color: black; }
        .navbar .user-info { float: right; color: white; padding: 14px 16px; }

        .home-container { text-align: center; padding: 50px 20px; }
        .home-container h1 { color: #333; }
        .buttons { margin-top: 30px; }
        .buttons a, .buttons button {
            display: inline-block;
            margin: 10px;
            padding: 15px 30px;
            font-size: 18px;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .buttons a:hover, .buttons button:hover { background-color: #0056b3; }
        .guest-options { margin-top: 20px; }
        .guest-options p { margin: 10px 0; }
        .messages p { padding: 10px; margin: 10px auto; width: 80%; max-width: 500px; border-radius: 5px; }
        .success-message { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb;}
        .error-message { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;}
    </style>
</head>
<body>

<div class="home-container">
    <h1>Добро пожаловать в Систему Обращений Граждан!</h1>

    <div class="buttons">
        <a href="${pageContext.request.contextPath}/user/login">Вход для Граждан</a>
        <a href="${pageContext.request.contextPath}/admin/login">Вход для Сотрудников</a>
    </div>

</div>
</body>
</html>
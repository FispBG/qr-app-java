<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Проверить статус заявления</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <style>
        .container { max-width: 500px; margin: 30px auto; padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .check-status-form .form-group { margin-bottom: 20px; }
        .check-status-form label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        .check-status-form input[type="text"] { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-size: 16px; }
        .submit-container { text-align: center; }
        .btn-primary { background-color: #007bff; color: white; padding: 12px 25px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; transition: background-color 0.3s; }
        .btn-primary:hover { background-color: #0056b3; }
        .btn-secondary { display: inline-block; margin-bottom:20px; text-decoration: none; background-color: #6c757d; color: white; padding: 8px 15px; border-radius: 4px; }
        .btn-secondary:hover { background-color: #545b62; }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Обратно на главную</a>

<div class="container">
    <h1>Проверить статус заявления</h1>
    <form class="check-status-form" action="${pageContext.request.contextPath}/appeal/check" method="post" accept-charset="UTF-8">
        <div class="form-group">
            <label for="applicantName">Ваше ФИО (как указано в заявлении):</label>
            <input type="text" id="applicantName" name="applicantName" value="${appeal.applicantName}" required>
        </div>

        <div class="submit-container">
            <button type="submit" class="btn btn-primary">Проверить</button>
        </div>
    </form>
</div>
</body>
</html>
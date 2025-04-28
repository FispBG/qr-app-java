<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Выбор опции</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <style>
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .modal-content {
            background-color: white;
            width: 50%;
            max-width: 500px;
            margin: 15% auto;
            padding: 20px;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            position: relative;
        }

        .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
        }

        .home-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="home-container">
    <h1>Выбор опции</h1>
    <div class="buttons">
        <a href="appeal/create">Создать обращений</a>
        <a href="/appeal/check">Узнать состояние обращения</a>
        <a href="/admin/list">Панель работника</a>
    </div>

    <div id="modal-1" class="modal">
        <div class="modal-content">
            <span class="close-button" onclick="closeModal('modal-1')">&times;</span>
            <h1>Заключение</h1>
            <form action="find" method="post">
                <div class="form-group">
                    <label for="applicantName">ФИО</label>
                    <input type="text" name="applicantName" id="applicantName" required="true"/>
                </div>
                <button type="submit" class="btn btn-primary">Поиск</button>
            </form>
        </div>
    </div>
</div>

<script>
    function closeModal(modalId) {
        document.getElementById(modalId).style.display = "none";
    }
</script>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 03.04.2025
  Time: 23:30
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Создание обращения</title>
    <style>
        :root {
            --primary-blue: #1a73e8;
            --light-blue: #e8f0fe;
            --accent-color: #ff6b6b;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --input-gray: #f0f0f0;
            --border-radius: 8px;
            --box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            --box-shadow-hover: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        body {
            font-family: 'Roboto', Arial, sans-serif;
            background-color: white;
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: var(--primary-blue);
            text-align: center;
            margin: 60px 0 30px;
            font-weight: 500;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: var(--border-radius);
            font-size: 16px;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--box-shadow);
            vertical-align: middle;
            box-sizing: border-box;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--box-shadow-hover);
            text-decoration: none;
        }

        .btn-primary {
            background-color: var(--primary-blue);
            color: white;
            padding: 12px 25px;
        }

        .btn-primary:hover {
            background-color: #0d62d0;
        }

        .btn-secondary {
            position: fixed;
            top: 20px;
            left: 20px;
            padding: 8px 16px;
            background-color: #6c757d;
            color: white;
            font-size: 14px;
            z-index: 100;
            border-radius: var(--border-radius);
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: var(--box-shadow);
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-1px);
            text-decoration: none;
            color: white;
        }

        .appeal-form {
            max-width: 800px;
            margin: 0 auto 40px;
            padding: 30px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        .applicant-fields {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }

        .applicant-fields .form-group {
            flex: 1;
            margin-bottom: 0;
        }

        .address-topic-fields {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-color);
            font-weight: 500;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            box-sizing: border-box;
            font-size: 16px;
            background-color: var(--input-gray);
            color: var(--text-color);
            font-family: 'Roboto', Arial, sans-serif;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
        }

        .content-field textarea {
            height: 150px;
            resize: vertical;
        }

        .submit-container {
            text-align: center;
            margin-top: 30px;
        }

        .submit-container button {
            min-width: 200px;
        }

        @media (max-width: 768px) {
            .applicant-fields {
                flex-direction: column;
                gap: 15px;
            }

            .appeal-form {
                padding: 20px;
                margin: 0 15px 30px;
            }

            h1 {
                margin: 50px 0 25px;
                font-size: 24px;
            }

            .btn-secondary {
                position: relative;
                top: 15px;
                left: 15px;
                display: inline-block;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
<a href="/" class="btn btn-secondary">Обратно в меню</a>

<h1>Создание обращения</h1>

<form action="/appeal/save" method="post" class="appeal-form">
    <div class="applicant-fields">
        <div class="form-group">
            <label for="applicantName">ФИО заявителя:</label>
            <input type="text" id="applicantName" name="applicantName" required>
        </div>
        <div class="form-group">
            <label for="managerName">ФИО руководителя:</label>
            <input type="text" id="managerName" name="managerName" required>
        </div>
    </div>

    <div class="address-topic-fields">
        <div class="form-group">
            <label for="address">Адрес:</label>
            <input type="text" id="address" name="address" required>
        </div>
        <div class="form-group">
            <label for="topic">Тема:</label>
            <input type="text" id="topic" name="topic" required>
        </div>
    </div>

    <div class="form-group content-field">
        <label for="content">Содержание обращения:</label>
        <textarea id="content" name="content" rows="6" required></textarea>
    </div>

    <input type="hidden" name="list" value="${list}">

    <div class="submit-container">
        <button type="submit" class="btn btn-primary">Сохранить</button>
    </div>
</form>
</body>
</html>
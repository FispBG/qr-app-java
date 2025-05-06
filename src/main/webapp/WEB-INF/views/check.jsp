<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 08.04.2025
  Time: 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Проверить статус заявления</title>
    <style>
        /* Global Variables */
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

        /* Base Styles */
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
            margin: 40px 0 30px;
            font-weight: 500;
        }

        /* Container */
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Form Styles */
        .check-status-form {
            max-width: 500px;
            margin: 0 auto;
            padding: 25px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        .form-group {
            margin: 0 auto 30px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: var(--text-color);
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            box-sizing: border-box;
            font-size: 16px;
            background-color: var(--input-gray);
            color: var(--text-color);
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
        }

        /* Button Styles */
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
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--box-shadow-hover);
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
            background-color: #6c757d;
            color: white;
            position: fixed;
            top: 20px;
            left: 20px;
            padding: 8px 16px;
            font-size: 14px;
            z-index: 100;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-1px);
        }

        .submit-container {
            text-align: center;
            margin-top: 30px;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .check-status-form {
                padding: 20px;
                margin: 0 15px;
            }

            .btn-secondary {
                position: static;
                display: block;
                margin: 20px auto 0;
            }
        }

        @media print {
            .btn-secondary,
            .submit-container button {
                display: none !important;
            }

            .check-status-form {
                box-shadow: none;
                border: 1px solid #ccc;
            }
        }
    </style>
</head>
<body>
<a href="/" class="btn btn-secondary">Обратно в меню</a>
<h1>Проверить статус заявления</h1>

<div class="container">
    <form class="check-status-form" action="check" method="post" accept-charset="UTF-8">
        <div class="form-group">
            <label for="applicantName">Ваше ФИО:</label>
            <input type="text" id="applicantName" name="applicantName" required>
        </div>

        <div class="submit-container">
            <button type="submit" class="btn btn-primary">Проверить</button>
        </div>
    </form>
</div>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 07.04.2025
  Time: 22:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вход сотрудника</title>
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
            margin: 30px 0;
            font-weight: 500;
        }

        /* Login Container */
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            text-align: center;
        }

        /* Form Styles */
        .login-form {
            margin-top: 30px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-color);
            font-weight: 500;
        }

        .login-input {
            width: 100%;
            padding: 12px;
            margin: 8px 0 0;
            border: 1px solid #ddd;
            border-radius: var(--border-radius);
            background-color: var(--input-gray);
            color: var(--text-color);
            box-sizing: border-box;
            font-size: 16px;
        }

        .login-input:focus {
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

        .login-button {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            font-size: 16px;
            background-color: var(--primary-blue);
            color: white;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .login-container {
                margin: 30px 15px;
                padding: 20px;
            }

            .btn-secondary {
                position: relative;
                display: block;
                margin: 20px auto 0;
                top: auto;
                left: auto;
            }
        }

        @media print {
            .btn-secondary {
                display: none !important;
            }

            .login-container {
                box-shadow: none;
                border: 1px solid #ccc;
                margin: 0 auto;
            }
        }
    </style>
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
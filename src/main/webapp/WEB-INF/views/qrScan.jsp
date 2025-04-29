<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>QR-код декодер</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            padding: 20px;
        }

        h1 {
            color: var(--primary-blue);
            text-align: center;
            margin: 30px 0;
            font-weight: 500;
        }

        h2, h3, h4 {
            color: var(--primary-blue);
            margin-top: 20px;
            margin-bottom: 15px;
        }

        .upload-container, .result-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 25px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }

        .result-container {
            background-color: var(--light-gray);
        }

        .back-button {
            background-color: #6c757d;
            color: white;
            padding: 8px 16px;
            border-radius: var(--border-radius);
            text-decoration: none;
            transition: all 0.3s ease;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 100;
            box-shadow: var(--box-shadow);
        }

        .back-button:hover {
            background-color: #5a6268;
            transform: translateY(-1px);
            text-decoration: none;
            color: white;
        }

        .file-input-container {
            margin: 20px 0;
        }

        input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px dashed var(--primary-blue);
            border-radius: var(--border-radius);
            background-color: var(--light-blue);
        }

        .button {
            background-color: var(--primary-blue);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 20px auto;
            text-align: center;
        }

        .button:hover {
            background-color: #0d62d0;
            transform: translateY(-2px);
            box-shadow: var(--box-shadow-hover);
        }

        pre {
            background-color: white;
            padding: 15px;
            border-radius: var(--border-radius);
            overflow-x: auto;
            white-space: pre-wrap;
            word-wrap: break-word;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
<a href="/admin/list" class="back-button">Вернуться к списку</a>

<h1>QR-код декодер</h1>

<div class="upload-container">
    <h2>Загрузите изображение с QR-кодом</h2>
    <form method="POST" action="<c:url value='/admin/decode'/>" enctype="multipart/form-data">
        <div class="file-input-container">
            <input type="file" name="image" accept="image/*" required>
        </div>
        <button type="submit" class="button">Распознать QR-код</button>
    </form>
</div>

<c:if test="${not empty message}">
    <div class="result-container">
        <h3>Результат:</h3>
        <p>${message}</p>
        <c:if test="${not empty qrCode}">
            <h4>Содержимое QR-кода:</h4>
            <pre>${qrCode}</pre>
            <form method="POST" action="<c:url value='/admin/saveAppealQr'/>">
                <input type="hidden" name="appeal" value="${qrCode}">
                <button type="submit" class="button">Добавить запись</button>
            </form>
        </c:if>
    </div>
</c:if>
</body>
</html>
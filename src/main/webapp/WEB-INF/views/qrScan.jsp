<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>QR-код декодер</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
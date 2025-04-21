<%-- Файл: src/main/webapp/WEB-INF/views/qrScan.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>QR-код декодер</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<h1>QR-код декодер</h1>

<div class="upload-container">
    <h2>Загрузите изображение с QR-кодом</h2>
    <%-- Форма отправляет POST запрос на /admin/decode --%>
    <form method="POST" action="<c:url value='/admin/decode'/>" enctype="multipart/form-data">
        <input type="file" name="image" accept="image/*" required>
        <br>
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
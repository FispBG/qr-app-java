<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Создание обращения</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <style>
        .appeal-form { max-width: 700px; margin: 20px auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; background-color: #f9f9f9;}
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input[type="text"], .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .form-group textarea { min-height: 100px; resize: vertical; }
        .submit-container { text-align: center; margin-top: 20px; }
        .btn-primary { background-color: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn-primary:hover { background-color: #0056b3; }
        .btn-secondary { display: inline-block; margin-bottom:20px; text-decoration: none; background-color: #6c757d; color: white; padding: 8px 15px; border-radius: 4px; }
        .btn-secondary:hover { background-color: #545b62; }
        .applicant-fields, .address-topic-fields { display: flex; justify-content: space-between; gap: 20px; }
        .applicant-fields .form-group, .address-topic-fields .form-group { flex: 1; }
        @media (max-width: 600px) {
            .applicant-fields, .address-topic-fields { flex-direction: column; gap: 0; }
        }
    </style>
</head>
<body>

<!-- Кнопка Назад/На главную -->
<c:choose>
    <c:when test="${not empty sessionScope.loggedInUser and sessionScope.authenticatedUserType == 'citizen'}">
        <a href="${pageContext.request.contextPath}/appeal/my-appeals" class="btn btn-secondary">К моим обращениям</a>
    </c:when>
    <c:when test="${not empty sessionScope.adminUsername and sessionScope.authenticatedUserType == 'admin'}">
        <a href="${pageContext.request.contextPath}/admin/list" class="btn btn-secondary">К списку</a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">На главную</a>
    </c:otherwise>
</c:choose>


<h1>Создание обращения</h1>
<c:if test="${not empty successMessage}">
    <p style="color:green; background-color: #e6ffe6; padding: 10px; border: 1px solid green;">${successMessage}</p>
</c:if>
<c:if test="${not empty errorMessage}">
    <p style="color:red; background-color: #ffe6e6; padding: 10px; border: 1px solid red;">${errorMessage}</p>
</c:if>

<form action="${pageContext.request.contextPath}/appeal/save" method="post" class="appeal-form">
    <div class="applicant-fields">
        <div class="form-group">
            <label for="applicantName">ФИО заявителя:</label>
            <input type="text" id="applicantName" name="applicantName"
                   value="${appeal.applicantName}" <%-- Pre-filled by controller if citizen --%>
                   required
                   <c:if test="${not empty sessionScope.loggedInUser and sessionScope.authenticatedUserType == 'citizen'}">readonly</c:if> >
        </div>
        <div class="form-group">
            <label for="managerName">ФИО руководителя:</label> <%-- Usually for internal routing --%>
            <input type="text" id="managerName" name="managerName" value="${appeal.managerName}" required>
        </div>
    </div>

    <div class="address-topic-fields">
        <div class="form-group">
            <label for="address">Адрес фактического проживания:</label>
            <input type="text" id="address" name="address" value="${appeal.address}" required>
        </div>
        <div class="form-group">
            <label for="topic">Тема обращения:</label>
            <input type="text" id="topic" name="topic" value="${appeal.topic}" required>
        </div>
    </div>

    <div class="form-group content-field">
        <label for="content">Содержание обращения:</label>
        <textarea id="content" name="content" rows="6" required>${appeal.content}</textarea>
    </div>

    <%-- Этот параметр нужен, если форма используется из админской части /admin/create --%>
    <%-- list=true означает, что после сохранения нужно вернуться на /admin/list --%>
    <%-- Для /appeal/create этот параметр обычно false или отсутствует --%>
    <input type="hidden" name="list" value="${list}">


    <div class="submit-container">
        <button type="submit" class="btn btn-primary">Сохранить обращение</button>
    </div>
</form>
</body>
</html>
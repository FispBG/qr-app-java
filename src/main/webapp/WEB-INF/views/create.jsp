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
<meta charset="UTF-8">
<html>
<head>
    <title>Создание обращения</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <c:if test = "${not empty officeId}">
        <a href="/admin/list" class="btn btn-secondary">Обратно в меню</a>
    </c:if>
    <c:if test = "${empty officeId}">
        <a href="/" class="btn btn-secondary">Обратно в меню</a>
    </c:if>
    <h1>Создание обращения</h1>
    <form:form action="/appeal/save" method="post" modelAttribute="appeal" accept-charset="UTF-8" cssClass="appeal-form">
        <div class="applicant-fields">
            <div class="form-group">
                <label for="applicantName">ФИО заявителя:</label>
                <form:input path="applicantName" required="true"/>
            </div>
            <div class="form-group">
                <label for="managerName">ФИО руководителя:</label>
                <form:input path="managerName" required="true"/>
            </div>
        </div>

        <div class="address-topic-fields">
            <div class="form-group">
                <label for="address">Адрес:</label>
                <form:input path="address" required="true"/>
            </div>
            <div class="form-group">
                <label for="topic">Тема:</label>
                <form:input path="topic" required="true"/>
            </div>
        </div>

        <div class="form-group content-field">
            <label for="content">Содержание обращения:</label>
            <form:textarea path="content" rows="6" required="true"/>
        </div>

        <input type="hidden" name="list" value="${list}">

        <div class="submit-container">
            <button type="submit" class="btn btn-primary">Сохранить</button>
        </div>
    </form:form>

</body>
</html>
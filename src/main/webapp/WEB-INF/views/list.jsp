<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 01.04.2025
  Time: 22:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Список заявлений</title>
</head>
<body>
<div class="buttons">
  <c:if test="${officeId == 1}">
    <a href="/appeal/create">Создать новое обращение</a>
    <a>Печать новых обращений</a>
  </c:if>
  <c:if test="${officeId == 2}">
    <a href="/admin/viewNew">Просмотр на рассмотрение</a>
    <a>Печать рассмотренных заявлений</a>
    <a>Сканировать Qr-код</a>
  </c:if>
</div>
<h1>Список заявлений</h1>
<div>
  <table>
    <thead>
    <tr>
      <th>Id</th>
      <th>Заявитель</th>
      <th>Руководитель</th>
      <th>Тема</th>
      <th>Статус</th>
      <th>Действие</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${appeals}" var="appeal">
      <tr>
        <td>${appeal.id}</td>
        <td>${appeal.applicantName}</td>
        <td>${appeal.managerName}</td>
        <td>${appeal.topic}</td>
        <td>${appeal.status}</td>
        <td>
          <a href="${appeal.id}">Посмотреть</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>

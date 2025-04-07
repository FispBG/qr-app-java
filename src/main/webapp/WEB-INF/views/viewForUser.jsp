<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 03.04.2025
  Time: 23:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<style>
  @media print {
    @page {
      size: auto;
      margin: 0;
    }

    .page-header,
    .page-footer,
    .buttons {
      display: none !important;
    }

  }
</style>
<head>
    <title>Просмотр обращения</title>
</head>
<body>
  <div class="buttons">
    <a href="/appeal/list">Вернуться к списку</a>
    <a href="" onclick="window.print()">Распечатать</a>
  </div>
  <div>
    <p>UUID: ${appeal.uuid}</p>
    <p>Заявитель: ${appeal.applicantName}</p>
    <p>Руководитель: ${appeal.managerName}</p>
    <p>Адрес: ${appeal.address}</p>
    <p>Тема: ${appeal.topic}</p>
    <p>Содержимое: ${appeal.content}</p>
    <p>Статус: ${appeal.status}</p>
    <p>Было распечатано: ${appeal.printer}</p>

    <c:if test="${not empty appeal.resolution}">
      <p>Резолюция: ${appeal.resolution}</p>
    </c:if>

    <c:if test="${not empty appeal.notes}">
      <p>Примечания: ${appeal.notes}</p>
    </c:if>
  </div>
  <div>
    <img src="${qrCode}" alt="QR обращения">
  </div>
</body>
</html>

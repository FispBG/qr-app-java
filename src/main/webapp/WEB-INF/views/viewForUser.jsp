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
  .modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
    z-index: 1000;
  }

  .modal-content {
    background-color: white;
    width: 50%;
    max-width: 500px;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    position: relative;
  }

  .close-button {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 20px;
    font-weight: bold;
    cursor: pointer;
  }
</style>
<head>
    <title>Просмотр обращения</title>
</head>
<body>
  <div class="buttons">
    <c:if test="${not empty qrCode}">
      <a href="/admin/list">Вернуться к списку</a>
    </c:if>
    <c:if test="${empty qrCode}">
      <a href="/appeal/check">Вернуться к списку</a>
    </c:if>
    <a href="" onclick="window.print()">Распечатать</a>
  </div>
  <div>
    <c:if test="${not empty qrCode}">
        <form action="/admin/delete" method="post" style="display: inline;">
          <input type="hidden" name="id" value="${appeal.id}"/>
          <button type="submit">Удалить обращение</button>
        </form>
    </c:if>
    <c:if test="${officeId == 2}">
      <button onclick="openModal('modal-${appeal.id}')">Рассмотреть</button>

      <div id="modal-${appeal.id}" class="modal">
        <div class="modal-content">
          <span class="close-button" onclick="closeModal('modal-${appeal.id}')">&times;</span>
          <h1>Заключение</h1>
          <form action="update" method="post">
            <input type="hidden" name="id" value="${appeal.id}"/>
            <input type="hidden" name="uuid" value="${appeal.uuid}"/>
            <input type="hidden" name="applicantName" value="${appeal.applicantName}"/>
            <input type="hidden" name="managerName" value="${appeal.managerName}"/>
            <input type="hidden" name="address" value="${appeal.address}"/>
            <input type="hidden" name="topic" value="${appeal.topic}"/>
            <input type="hidden" name="content" value="${appeal.content}"/>

            <div class="form-group">
              <select name="status">
                <option value="Рассмотрено">Рассмотрено</option>
                <option value="Отклонено">Отклонено</option>
              </select>
            </div>

            <div class="form-group">
              <label for="resolution">Резолюция</label>
              <input type="text" name="resolution" required="true"/>
            </div>

            <div class="form-group">
              <label for="notes">Примечание</label>
              <input type="text" name="notes"/>
            </div>

            <button type="submit" class="btn btn-primary">Сохранить</button>
          </form>
        </div>
      </div>
    </c:if>
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
    <c:if test="${not empty qrCode}">
      <img src="${qrCode}" alt="QR обращения">
    </c:if>
  </div>
</body>

<script>
  function openModal(modalId) {
    document.getElementById(modalId).style.display = "block";
  }

  function closeModal(modalId) {
    document.getElementById(modalId).style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target.className === "modal") {
      event.target.style.display = "none";
    }
  }
</script>
</html>

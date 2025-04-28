<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Просмотр обращения</title>
  <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h1>Просмотр обращения</h1>

  <div class="buttons no-print">
    <div class="buttons-group">
      <c:if test="${not empty qrCode}">
        <a href="/admin/list" class="view-btn btn-primary">Вернуться к списку</a>
      </c:if>
      <c:if test="${empty qrCode}">
        <a href="/appeal/check" class="view-btn btn-primary">Вернуться к списку</a>
      </c:if>
      <a href="" onclick="window.print(); return false;" class="view-btn btn-primary">Распечатать</a>
    </div>
    <div class="buttons-group">
      <c:if test="${not empty qrCode}">
        <form action="/admin/delete" method="post" style="display: inline;">
          <input type="hidden" name="id" value="${appeal.id}"/>
          <button type="submit" class="view-btn btn-danger">Удалить обращение</button>
        </form>
      </c:if>
      <c:if test="${officeId == 2}">
        <button onclick="openModal('modal-${appeal.id}')" class="view-btn btn-primary">Рассмотреть</button>
      </c:if>
    </div>
  </div>

  <div class="appeal-details">
    <div class="appeal-info-row">
      <div class="appeal-label">UUID:</div>
      <div class="appeal-value">${appeal.uuid}</div>
    </div>
    <div class="appeal-info-row">
      <div class="appeal-label">Заявитель:</div>
      <div class="appeal-value">${appeal.applicantName}</div>
    </div>
    <div class="appeal-info-row">
      <div class="appeal-label">Руководитель:</div>
      <div class="appeal-value">${appeal.managerName}</div>
    </div>
    <div class="appeal-info-row">
      <div class="appeal-label">Адрес:</div>
      <div class="appeal-value">${appeal.address}</div>
    </div>
    <div class="appeal-info-row">
      <div class="appeal-label">Тема:</div>
      <div class="appeal-value">${appeal.topic}</div>
    </div>
    <div class="appeal-info-row">
      <div class="appeal-label">Содержимое:</div>
      <div class="appeal-value">${appeal.content}</div>
    </div>
    <div class="appeal-info-row">
      <div class="appeal-label">Статус:</div>
      <div class="appeal-value">${appeal.status}</div>
    </div>
    <div class="appeal-info-row">
      <div class="appeal-label">Было распечатано:</div>
      <div class="appeal-value">${appeal.printer}</div>
    </div>

    <c:if test="${not empty appeal.resolution}">
      <div class="appeal-info-row">
        <div class="appeal-label">Резолюция:</div>
        <div class="appeal-value">${appeal.resolution}</div>
      </div>
    </c:if>

    <c:if test="${not empty appeal.notes}">
      <div class="appeal-info-row">
        <div class="appeal-label">Примечания:</div>
        <div class="appeal-value">${appeal.notes}</div>
      </div>
    </c:if>
  </div>

  <c:if test="${not empty qrCode}">
    <div class="qr-container">
      <img src="${qrCode}" alt="QR обращения">
    </div>
  </c:if>

  <c:if test="${officeId == 2}">
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
            <label for="status">Статус</label>
            <select name="status" id="status">
              <option value="Рассмотрено">Рассмотрено</option>
              <option value="Отклонено">Отклонено</option>
            </select>
          </div>

          <div class="form-group">
            <label for="resolution">Резолюция</label>
            <input type="text" id="resolution" name="resolution" required="true"/>
          </div>

          <div class="form-group">
            <label for="notes">Примечание</label>
            <input type="text" id="notes" name="notes"/>
          </div>

          <button type="submit" class="view-btn btn-primary">Сохранить</button>
        </form>
      </div>
    </div>
  </c:if>
</div>

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
</body>
</html>
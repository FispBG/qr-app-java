<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Просмотр обращения</title>
<%--  <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">--%>
  <style>
    /* Переменные */
    :root {
      --primary-blue: #1a73e8;
      --light-blue: #e8f0fe;
      --accent-color: #ff6b6b; /* Для кнопки удаления */
      --text-color: #333;
      --light-gray: #f5f5f5;
      --input-gray: #f0f0f0;
      --border-radius: 8px;
      --box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      --box-shadow-hover: 0 4px 8px rgba(0, 0, 0, 0.2);
      --box-shadow-modal: 0 5px 15px rgba(0, 0, 0, 0.3);
    }

    /* Базовые стили */
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

    /* Основной контейнер */
    .container {
      max-width: 1000px;
      margin: 0 auto;
      padding: 20px;
    }

    /* Стили для кнопок */
    .btn-standard {
      width: 220px !important;
      padding: 10px 0;
      text-align: center;
      display: inline-block;
      border-radius: var(--border-radius);
      font-size: 16px;
      font-weight: normal;
      cursor: pointer;
      transition: all 0.3s ease;
      text-decoration: none;
      border: none;
      margin: 0 10px;
      box-sizing: border-box;
    }

    .btn-primary {
      background-color: var(--primary-blue);
      color: white;
    }

    .btn-primary:hover {
      background-color: #0d62d0;
      color: white;
      transform: translateY(-2px);
      box-shadow: var(--box-shadow-hover);
    }

    .btn-danger {
      background-color: var(--accent-color);
      color: white;
    }

    .btn-danger:hover {
      background-color: #e05555;
      color: white;
      transform: translateY(-2px);
      box-shadow: var(--box-shadow-hover);
    }

    .btn-secondary {
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

    .btn-secondary:hover {
      background-color: #5a6268;
      transform: translateY(-1px);
      text-decoration: none;
    }

    /* Группа кнопок */
    .buttons {
      display: flex;
      justify-content: flex-start;
      flex-wrap: wrap;
      gap: 20px;
      margin: 30px 0;
    }

    /* Форма удаления */
    .delete-form {
      margin: 0;
      padding: 0;
      display: inline-block;
    }

    /* Детали обращения */
    .appeal-details {
      background-color: white;
      border-radius: var(--border-radius);
      box-shadow: var(--box-shadow);
      padding: 25px;
      margin: 30px 0;
    }

    .appeal-info-row {
      margin-bottom: 15px;
      display: flex;
      gap: 15px;
    }

    .appeal-label {
      font-weight: 500;
      width: 150px;
      color: var(--primary-blue);
      flex-shrink: 0;
    }

    .appeal-value {
      flex: 1;
      color: var(--text-color);
    }

    /* QR код */
    .qr-container {
      text-align: center;
      margin-top: 30px;
      padding: 15px;
      background-color: var(--light-blue);
      border-radius: var(--border-radius);
      display: inline-block;
      margin-left: 50%;
      transform: translateX(-50%);
    }

    .qr-container img {
      max-width: 200px;
      height: auto;
      display: block;
    }

    /* Модальное окно */
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
      width: 80%;
      max-width: 500px;
      margin: 15% auto;
      padding: 20px;
      border-radius: var(--border-radius);
      box-shadow: var(--box-shadow-modal);
      position: relative;
    }

    .close-button {
      position: absolute;
      top: 10px;
      right: 15px;
      font-size: 24px;
      font-weight: bold;
      cursor: pointer;
      color: var(--text-color);
      line-height: 1;
    }

    .close-button:hover {
      color: var(--primary-blue);
    }

    /* Группы в форме */
    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: var(--text-color);
      font-weight: 500;
    }

    .form-group input,
    .form-group select,
    .form-group textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: var(--border-radius);
      box-sizing: border-box;
      font-size: 16px;
      background-color: var(--input-gray);
      color: var(--text-color);
    }

    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: var(--primary-blue);
      box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
    }

    /* Стили для печати */
    @media print {
      @page {
        size: auto;
        margin: 20mm;
      }

      body {
        background-color: white;
        color: black;
        font-size: 12pt;
      }

      .no-print,
      .btn-secondary,
      .buttons,
      .modal {
        display: none !important;
      }

      .container {
        max-width: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
        box-shadow: none !important;
      }

      .appeal-details {
        box-shadow: none !important;
        border: 1px solid #ccc;
        padding: 10mm;
      }

      h1 {
        font-size: 18pt;
        margin: 10mm 0;
      }

      .appeal-info-row {
        page-break-inside: avoid;
      }
    }
  </style>
</head>
<body>
<c:if test="${not empty qrCode}">
  <a href="/admin/list" class="back-button no-print btn-secondary">Вернуться к списку</a>
</c:if>
<c:if test="${empty qrCode}">
  <a href="/appeal/check" class="btn-secondary">Вернуться к списку</a>
</c:if>

<div class="container">
  <h1>Просмотр обращения</h1>

  <div class="buttons no-print">
    <a href="" onclick="window.print(); return false;" class="btn-standard btn-primary">Распечатать</a>
    <c:if test="${officeId == 2}">
      <button onclick="openModal('modal-${appeal.id}')" class="btn-standard btn-primary">Рассмотреть</button>
    </c:if>
    <c:if test="${not empty qrCode}">
      <div class="controls-container no-print">
        <a href="/admin/download?idOffice=${322}&id=${appeal.id}" class="btn-standard btn-primary">Скачать обращения</a>
      </div>
      <form action="/admin/delete" method="post" class="delete-form">
        <input type="hidden" name="id" value="${appeal.id}"/>
        <button type="submit" class="btn-standard btn-danger">Удалить обращение</button>
      </form>
    </c:if>
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
    <div id="modal-${appeal.id}" class="modal no-print">
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
          <button type="submit" class="btn-standard btn-primary" style="width: 100%; margin-top: 15px;">Сохранить</button>
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
    const modals = document.querySelectorAll('.modal');
    modals.forEach(modal => {
      if (event.target === modal) {
        modal.style.display = "none";
      }
    });
  }
</script>
</body>
</html>
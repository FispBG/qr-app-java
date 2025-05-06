<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<style type="text/css">
  /* ======================================== */
  /* Variables Used On This Page     */
  /* ======================================== */
  :root {
    --primary-blue: #1a73e8;
    --light-blue: #e8f0fe; /* Used for table hover */
    --text-color: #333;
    --light-gray: #f5f5f5; /* Used for table striping */
    --input-gray: #f0f0f0; /* Used for form inputs */
    --border-radius: 8px;
    --box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    --box-shadow-hover: 0 4px 8px rgba(0, 0, 0, 0.2);
    --box-shadow-modal: 0 5px 15px rgba(0, 0, 0, 0.3);
  }

  /* ======================================== */
  /* Basic Styles                    */
  /* ======================================== */
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

  /* ======================================== */
  /* Layout Container Used             */
  /* ======================================== */
  .container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 20px;
  }

  /* ======================================== */
  /* Button Styles Used              */
  /* ======================================== */
  .btn {
    display: inline-block;
    padding: 10px 20px; /* Base padding */
    border: none;
    border-radius: var(--border-radius);
    font-size: 16px;
    font-weight: 500;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: var(--box-shadow);
    vertical-align: middle;
    box-sizing: border-box;
  }

  .btn:hover {
    transform: translateY(-2px);
    box-shadow: var(--box-shadow-hover);
    text-decoration: none;
  }

  /* Standard Button Size Class */
  .btn-standard {
    width: 220px !important; /* Fixed width */
    padding: 10px 0; /* Adjust padding for fixed width */
    text-align: center;
    display: inline-block; /* Ensure display for sizing */
    margin: 5px; /* Add some margin */
  }

  /* Primary Button (Blue) - Used in Modal */
  .btn-primary {
    background-color: var(--primary-blue);
    color: white;
  }
  .btn-primary:hover {
    background-color: #0d62d0;
  }

  /* Secondary Button (Gray) - Used for Back Button */
  .btn-secondary {
    background-color: #6c757d;
    color: white;
  }
  .btn-secondary:hover {
    background-color: #5a6268;
  }

  /* ======================================== */
  /* Form Styles Used (Modal)        */
  /* ======================================== */
  .form-group {
    margin-bottom: 20px; /* Default spacing */
  }

  .form-group label {
    display: block;
    margin-bottom: 8px;
    color: var(--text-color);
    font-weight: 500;
  }

  /* Targeting specific input types used */
  .form-group input[type="text"],
  .form-group select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: var(--border-radius);
    box-sizing: border-box;
    font-size: 16px;
    background-color: var(--input-gray);
    color: var(--text-color);
  }

  /* Focus styles for inputs */
  .form-group input[type="text"]:focus,
  .form-group select:focus {
    outline: none;
    border-color: var(--primary-blue);
    box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
  }

  /* ======================================== */
  /* Modal Styles Used               */
  /* ======================================== */
  .modal {
    display: none; /* Hidden by default */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
    z-index: 1000;
    overflow-y: auto;
  }

  .modal-content {
    background-color: white;
    width: 80%;
    max-width: 500px;
    margin: 10% auto;
    padding: 30px;
    border-radius: var(--border-radius);
    box-shadow: var(--box-shadow-modal);
    position: relative;
  }

  /* Modal specific heading style */
  .modal-content h1 {
    margin-top: 0;
    margin-bottom: 25px;
    font-size: 24px;
    text-align: center;
    color: var(--primary-blue);
  }

  .close-button {
    position: absolute;
    top: 15px;
    right: 20px;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    color: var(--text-color);
    line-height: 1;
  }

  .close-button:hover {
    color: var(--primary-blue);
  }

  /* Form styling specifically inside the modal */
  .modal-content .form-group {
    margin-bottom: 15px;
  }

  .modal-content .form-group label {
    margin-bottom: 5px;
  }

  .modal-content .form-group select,
  .modal-content .form-group input[type="text"] {
    padding: 10px; /* Consistent padding */
  }

  /* Button override inside modal */
  .modal-content .btn-standard {
    width: 100% !important; /* Override standard width for modal */
    margin-left: 0;
    margin-right: 0;
  }
  .modal-content .btn {
    margin-top: 20px;
  }

  /* ======================================== */
  /* Table Styles Used               */
  /* ======================================== */
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    box-shadow: var(--box-shadow);
    border-radius: var(--border-radius);
    overflow: hidden;
  }

  th {
    background-color: var(--primary-blue);
    color: white;
    padding: 12px 10px;
    text-align: left;
    font-weight: 500;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  td {
    padding: 12px 10px;
    border-bottom: 1px solid #e0e0e0;
    font-size: 15px;
  }

  /* Alternating Row Colors */
  tbody tr:nth-child(even) {
    background-color: var(--light-gray);
  }
  tbody tr:nth-child(odd) {
    background-color: white;
  }
  tbody tr:hover {
    background-color: var(--light-blue); /* Light blue hover */
  }

  /* 'Review' link style */
  .review-link {
    color: var(--primary-blue);
    text-decoration: none;
    font-weight: 500;
    cursor: pointer;
    transition: color 0.2s ease;
  }

  .review-link:hover {
    text-decoration: underline;
    color: #0d62d0; /* Darker blue on hover */
  }

  /* ======================================== */
  /* Helper Classes Used             */
  /* ======================================== */
  .no-print {
    /* Style applied in @media print */
  }

  /* ======================================== */
  /* Print Styles for This Page      */
  /* ======================================== */
  @media print {
    @page {
      size: auto;
      margin: 20mm;
    }

    body {
      background-color: white !important;
      color: black !important;
      font-size: 10pt;
      font-family: 'Times New Roman', Times, serif;
      line-height: 1.4;
      margin: 0 !important;
      padding: 0 !important;
    }

    /* Hide elements not needed for print */
    .no-print,
    .modal, /* Hide modals */
    .review-link, /* Hide review link */
    th:last-child, /* Hide Action column header */
    td:last-child { /* Hide Action column cells */
      display: none !important;
    }
    /* Hide the standalone back button */
    body > div:first-of-type > a.btn {
      display: none !important;
    }

    .container {
      max-width: 100% !important;
      margin: 0 !important;
      padding: 0 !important;
      box-shadow: none !important;
      border: none !important;
    }

    h1 {
      font-size: 16pt;
      margin: 10mm 0;
      text-align: center;
      color: black !important;
    }

    a { /* General link styling for print */
      color: black !important;
      text-decoration: none !important;
    }

    table {
      box-shadow: none !important;
      border: 1px solid #999 !important;
      width: 100% !important;
      margin-top: 5mm;
      border-collapse: collapse !important;
      font-size: 10pt;
      border-radius: 0 !important; /* Remove radius for print */
      overflow: visible !important; /* Remove overflow hidden */
    }
    thead {
      display: table-header-group; /* Repeat headers */
    }
    th, td {
      border: 1px solid #999 !important;
      padding: 2mm 3mm;
      background-color: white !important;
      color: black !important;
      vertical-align: top;
    }
    th {
      background-color: #eee !important;
      font-weight: bold;
      text-transform: none;
      letter-spacing: normal;
      font-size: 10pt;
    }
    tbody tr {
      page-break-inside: avoid;
    }
  }

</style>
<head>
  <title>Просмотр новых заявок</title>
</head>
<body>

<a href="/admin/list" class="btn btn-secondary">Обратно в меню</a>

<div class="container">
  <table>
    <thead>
    <tr>
      <th>Id</th>
      <th>Заявитель</th>
      <th>Руководитель</th>
      <th>Адрес</th>
      <th>Тема</th>
      <th>Содержание</th>
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
        <td>${appeal.address}</td>
        <td>${appeal.topic}</td>
        <td>${appeal.content}</td>
        <td>${appeal.status}</td>
        <td>
          <span class="review-link" onclick="openModal('modal-${appeal.id}')">Рассмотреть</span>

          <!-- Модальное окно -->
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

                <button type="submit" class="btn btn-primary">Сохранить</button>
              </form>
            </div>
          </div>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>

<script>
  function toggleMenu() {
    document.body.classList.toggle("menu-open");
  }

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
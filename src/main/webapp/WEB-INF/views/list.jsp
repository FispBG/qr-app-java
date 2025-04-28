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
  <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
</head>
<body>
<!-- Кнопка выхода -->
<c:if test="${officeId != 0}">
  <a href="/admin/logout" class="logout-btn">Выйти из панели работника</a>
</c:if>
<c:if test="${officeId == 0}">
  <a href="/" class="logout-btn">Обратно в меню</a>
</c:if>

<!-- Гамбургер меню -->
<div class="hamburger-menu" onclick="toggleMenu()">
  <div class="hamburger-icon">
    <span></span>
    <span></span>
    <span></span>
  </div>
</div>

<div class="menu-items">
  <c:if test="${officeId == 1}">
    <a href="/admin/create">Создать новое обращение</a>
    <a href="/admin/viewCreated">Печать новых обращений</a>
    <a href="/admin/scan">Сканировать Qr-код</a>
  </c:if>
  <c:if test="${officeId == 2}">
    <a href="/admin/viewNew">Просмотр на рассмотрение</a>
    <a href="/admin/viewReviewed">Печать рассмотренных заявлений</a>
    <a href="/admin/scan">Сканировать Qr-код</a>
  </c:if>
</div>
<div class="overlay" onclick="toggleMenu()"></div>

<div class="container">
  <h1 class="text-center">Список заявлений</h1>

  <div class="filter-container">
    <label for="statusFilter">Фильтр по статусу:</label>
    <select id="statusFilter" onchange="filterByStatus()">
      <option value="all">Все статусы</option>
      <option value="Создано">Создано</option>
      <option value="Рассмотрено">Рассмотрено</option>
      <option value="Отклонено">Отклонено</option>
    </select>
  </div>

  <div>
    <table id="appealsTable">
      <thead>
      <tr>
        <th onclick="sortTable(0, true)" id="idHeader">Id <span class="sort-icon"></span></th>
        <th onclick="sortTable(1, false)" id="applicantHeader">Заявитель <span class="sort-icon"></span></th>
        <th onclick="sortTable(2, false)" id="managerHeader">Руководитель <span class="sort-icon"></span></th>
        <th>Тема</th>
        <th onclick="sortTable(4, false)" id="statusHeader">Статус <span class="sort-icon"></span></th>
        <th>Действие</th>
      </tr>
      </thead>
      <tbody id="appealsTableBody">
      <c:forEach items="${appeals}" var="appeal">
        <tr class="appeal-row" data-status="${appeal.status}">
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
</div>

<script>
  const columnSortOrders = {
    0: true, // ID column - initially ascending
    1: true, // Applicant column
    2: true, // Manager column
    4: true  // Status column
  };

  function sortTable(columnIndex, isNumeric) {
    const table = document.getElementById("appealsTable");
    const rows = Array.from(table.querySelectorAll("tbody tr"));

    document.querySelectorAll("th .sort-icon").forEach(icon => {
      icon.classList.remove("asc");
    });

    const headers = ["idHeader", "applicantHeader", "managerHeader", "", "statusHeader"];
    const currentHeader = document.getElementById(headers[columnIndex]);
    if (currentHeader) {
      const sortIcon = currentHeader.querySelector(".sort-icon");
      if (columnSortOrders[columnIndex]) {
        sortIcon.classList.add("asc");
      }
    }

    rows.sort((a, b) => {
      let aValue = a.cells[columnIndex].textContent.trim();
      let bValue = b.cells[columnIndex].textContent.trim();

      if (isNumeric) {
        aValue = parseInt(aValue);
        bValue = parseInt(bValue);
        return columnSortOrders[columnIndex] ? aValue - bValue : bValue - aValue;
      } else {
        return columnSortOrders[columnIndex]
                ? aValue.localeCompare(bValue)
                : bValue.localeCompare(aValue);
      }
    });

    columnSortOrders[columnIndex] = !columnSortOrders[columnIndex];

    const tbody = table.querySelector("tbody");
    tbody.innerHTML = "";
    rows.forEach(row => tbody.appendChild(row));
  }

  function filterByStatus() {
    const selectedStatus = document.getElementById("statusFilter").value;
    const rows = document.querySelectorAll(".appeal-row");

    rows.forEach(row => {
      const status = row.getAttribute("data-status");
      row.style.display = (selectedStatus === "all" || status === selectedStatus) ? "" : "none";
    });
  }

  function toggleMenu() {
    document.body.classList.toggle("menu-open");
  }

  document.addEventListener("DOMContentLoaded", function() {
    sortTable(0, true);
  });
</script>
</body>
</html>
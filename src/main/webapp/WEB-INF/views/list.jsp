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
<style>
  /* ======================================== */
  /* Relevant Global Styles & Variables */
  /* ======================================== */
  :root {
    --primary-blue: #1a73e8;
    --light-blue: #e8f0fe;
    /* --accent-color: #ff6b6b; /* Not used on this page */
    --text-color: #333;
    --light-gray: #f5f5f5;   /* Used in filters/tables */
    --input-gray: #f0f0f0;   /* Used in filters/tables */
    --border-radius: 8px;
    --box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    /* --box-shadow-hover: 0 4px 8px rgba(0, 0, 0, 0.2); /* Implicitly used via hover */
    /* --box-shadow-modal: 0 5px 15px rgba(0, 0, 0, 0.3); /* Not used */
    /* --box-shadow-large: 0 4px 20px rgba(0, 0, 0, 0.1); /* Not used */
  }

  body {
    font-family: 'Roboto', Arial, sans-serif;
    background-color: white;
    color: var(--text-color);
    line-height: 1.6;
    margin: 0;
    padding: 0;
    /* Add transition for menu opening */
    transition: margin-left 0.3s ease-in-out;
  }

  h1 {
    color: var(--primary-blue);
    text-align: center;
    margin: 30px 0; /* Default margin */
    font-weight: 500;
  }

  a { /* Base link style, needed for table links */
    color: var(--primary-blue);
    text-decoration: none;
    cursor: pointer;
  }
  a:hover {
    text-decoration: underline;
  }


  /* ======================================== */
  /* Relevant Layout Containers         */
  /* ======================================== */
  .container {
    max-width: 1200px; /* Default max-width */
    margin: 0 auto;    /* Centering */
    padding: 20px;     /* Default padding */
  }

  /* ======================================== */
  /* Relevant Button Styles             */
  /* ======================================== */

  /* Logout Button (Fixed Position) */
  .logout-btn {
    position: fixed;
    top: 20px;
    right: 20px;
    padding: 8px 16px;
    background-color: #6c757d; /* Secondary color */
    color: white;
    font-size: 14px;
    z-index: 1000;
    border: none;
    border-radius: var(--border-radius);
    text-decoration: none;
    transition: all 0.3s ease;
    box-shadow: var(--box-shadow);
    cursor: pointer;
  }
  .logout-btn:hover {
    background-color: #5a6268;
    transform: translateY(-1px);
    text-decoration: none; /* Overrides base 'a:hover' */
  }

  /* ======================================== */
  /* Hamburger Menu / Sidebar        */
  /* ======================================== */
  .hamburger-menu { /* Container for the icon */
    position: fixed;
    top: 20px;
    left: 20px;
    z-index: 1000; /* Above overlay */
    cursor: pointer;
  }

  .hamburger-icon {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    width: 30px;
    height: 24px;
  }

  .hamburger-icon span { /* The bars */
    width: 100%;
    height: 3px;
    background-color: var(--primary-blue);
    border-radius: 3px;
    transition: all 0.3s ease-in-out;
  }

  .menu-items { /* The sliding menu */
    position: fixed;
    top: 0;
    left: -250px; /* Start off-screen */
    width: 250px;
    height: 100%;
    background-color: white;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    transition: left 0.3s ease-in-out;
    z-index: 999; /* Below icon, above overlay */
    padding-top: 60px; /* Space for icon/header */
  }

  .menu-items a { /* Links within the menu */
    display: block;
    padding: 15px 20px;
    color: var(--text-color);
    text-decoration: none;
    transition: background-color 0.3s ease, color 0.3s ease;
  }

  .menu-items a:hover {
    background-color: var(--light-blue);
    color: var(--primary-blue);
    text-decoration: none; /* Overrides base 'a:hover' */
  }

  .overlay { /* Background dim */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: none; /* Hidden by default */
    z-index: 998; /* Below menu */
    cursor: pointer; /* Indicate it can be clicked to close */
  }

  /* Styles when menu is open (add .menu-open to body or container) */
  .menu-open .menu-items {
    left: 0; /* Slide in */
  }

  .menu-open .overlay {
    display: block; /* Show overlay */
  }

  .menu-open .hamburger-icon span:nth-child(1) { /* Top bar -> / */
    transform: translateY(10px) rotate(45deg);
  }

  .menu-open .hamburger-icon span:nth-child(2) { /* Middle bar -> fade out */
    opacity: 0;
  }

  .menu-open .hamburger-icon span:nth-child(3) { /* Bottom bar -> \ */
    transform: translateY(-10px) rotate(-45deg);
  }

  /* Shift body content when menu is open */
  .menu-open body {
    margin-left: 250px;
  }


  /* ======================================== */
  /* Table & Filter Styles           */
  /* ======================================== */
  table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    box-shadow: var(--box-shadow); /* Add shadow to tables */
    border-radius: var(--border-radius); /* Rounded corners for the table */
    overflow: hidden; /* Ensures border-radius clips children */
  }

  th {
    background-color: var(--primary-blue);
    color: white;
    padding: 12px 8px;
    text-align: left;
    font-weight: 500;
    cursor: pointer; /* Indicate sortable columns */
    user-select: none; /* Prevent text selection on click */
  }

  td {
    padding: 10px 8px;
    border-bottom: 1px solid #e0e0e0; /* Lighter border */
    background-color: white; /* Default background */
  }

  /* Remove bottom border for the last row */
  tbody tr:last-child td {
    border-bottom: none;
  }

  /* Alternating row colors */
  tbody tr:nth-child(odd) td {
    background-color: var(--light-blue); /* Use light blue for odd rows */
  }
  tbody tr:nth-child(even) td {
    background-color: white; /* Keep even rows white */
  }

  /* Hover effect for table rows */
  tbody tr:hover td {
    background-color: #d6e4f9; /* Slightly darker blue on hover */
  }


  /* Specific Table Cell Content Styling */
  #appealsTable a { /* Links within the appeals table */
    color: var(--primary-blue);
    /* Inherits base 'a' styles */
    font-weight: 500; /* Make link slightly bolder */
  }

  #appealsTable a:hover {
    /* Inherits base 'a:hover' underline */
  }

  /* Sorting Icons */
  th .sort-icon { /* Container for the icon */
    display: inline-block;
    width: 1em; /* Reserve space */
    text-align: center;
    color: white; /* Match header text color */
    opacity: 0.6; /* Make default icon slightly less prominent */
    transition: opacity 0.2s ease;
  }

  th:hover .sort-icon {
    opacity: 1; /* Full opacity on header hover */
  }

  th .sort-icon::after { /* Default icon (down arrow) */
    content: "▼";
    font-size: 0.8em;
  }

  th .sort-icon.asc::after { /* Ascending icon (up arrow) */
    content: "▲";
  }

  /* Style for the currently sorted column header */
  th.sorted-asc .sort-icon,
  th.sorted-desc .sort-icon {
    opacity: 1; /* Make sorted icon fully visible */
  }


  /* Filter Container */
  .filter-container {
    margin: 30px 0 20px 0;
    padding: 15px;
    background-color: white; /* Changed to white for contrast */
    border-radius: var(--border-radius);
    box-shadow: var(--box-shadow);
  }

  .filter-container label {
    margin-right: 10px;
    font-weight: 500;
    color: var(--text-color);
  }

  .filter-container select {
    padding: 8px 12px;
    border-radius: var(--border-radius);
    border: 1px solid #ddd;
    background-color: var(--input-gray);
    min-width: 150px; /* Give dropdown some width */
    cursor: pointer;
    font-size: 14px; /* Match logout button font-size perhaps */
  }
  .filter-container select:focus {
    outline: none;
    border-color: var(--primary-blue);
    box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
  }


  /* ======================================== */
  /* Helper Classes Used             */
  /* ======================================== */
  .text-center {
    text-align: center;
  }

  .no-print { /* Class to hide elements when printing */
    /* Rule applied within @media print */
  }

  /* Class applied to TR elements for filtering */
  .appeal-row {
    /* No specific style needed here unless for layout/spacing */
  }

  /* ======================================== */
  /* Relevant Print Styles           */
  /* ======================================== */
  @media print {
    @page {
      size: A4;
      margin: 20mm;
    }

    body {
      background-color: white !important;
      color: black !important;
      font-size: 11pt;
      margin: 0 !important;
      font-family: 'Times New Roman', Times, serif;
      line-height: 1.4;
    }

    /* Hide elements not needed for print */
    .no-print,
    .hamburger-menu,
    .logout-btn,
    .filter-container,
    .menu-items,
    .overlay,
    th .sort-icon, /* Hide sort icons */
    #appealsTable a[href] /* Hide "Посмотреть" links */
    {
      display: none !important;
    }

    /* Ensure container takes full width */
    .container {
      max-width: 100% !important;
      width: 100% !important;
      margin: 0 !important;
      padding: 0 !important;
      box-shadow: none !important;
      border: none !important;
    }

    h1 {
      font-size: 16pt;
      margin: 0 0 10mm 0;
      color: black !important;
    }

    /* Table print styles */
    table {
      box-shadow: none !important;
      border: 1px solid #999 !important;
      width: 100% !important;
      margin-top: 5mm;
      page-break-inside: auto;
    }
    thead {
      display: table-header-group;
    }
    tbody tr {
      page-break-inside: avoid;
    }
    th, td {
      border: 1px solid #ccc !important;
      padding: 2mm 3mm;
      background-color: white !important;
      color: black !important;
      font-size: 10pt;
    }
    th {
      background-color: #eee !important;
      font-weight: bold;
      cursor: default;
    }

    a { /* Ensure any remaining links are black */
      color: black !important;
      text-decoration: none !important;
    }
  }
</style>
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
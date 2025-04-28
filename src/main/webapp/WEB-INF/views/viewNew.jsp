<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Просмотр новых заявок</title>
  <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
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
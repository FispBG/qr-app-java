<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Печать рассмотренных заявлений</title>
    <link href="${pageContext.request.contextPath}/css/global.css" rel="stylesheet">
</head>
<body>
<a href="/admin/list" class="btn btn-secondary">Обратно в меню</a>
<div class="container">
    <h1 class="no-print">Печать рассмотренных заявлений</h1>

    <div class="controls-container no-print">
        <a href="/admin/download?idOffice=${office}" class="download-link">Скачать обращения</a>
        <button class="print-button" onclick="printDocuments()">Печать заявлений</button>
        <button class="print-button" onclick="markAsPrinted()">Отметить как напечатанные</button>
    </div>

    <form id="printForm" action="/admin/mark-as-printed" method="post">
        <input type="hidden" name="ids" value="<c:forEach items="${appeals}" var="appeal" varStatus="status">${appeal.id}<c:if test="${!status.last}">,</c:if></c:forEach>">
        <input type="hidden" name="idOffice" value="${office}">
    </form>

    <c:choose>
        <c:when test="${not empty appeals}">
            <c:forEach items="${appeals}" var="appeal">
                <div class="appeal-card">
                    <div class="appeal-header">
                        Заявление #${appeal.id}
                    </div>
                    <div class="appeal-body">
                        <div class="appeal-info">
                            <div class="appeal-row">
                                <span class="label">Заявитель:</span>
                                <span>${appeal.applicantName}</span>
                            </div>
                            <div class="appeal-row">
                                <span class="label">Руководитель:</span>
                                <span>${appeal.managerName}</span>
                            </div>
                            <div class="appeal-row">
                                <span class="label">Адрес:</span>
                                <span>${appeal.address}</span>
                            </div>
                            <div class="appeal-row">
                                <span class="label">Тема:</span>
                                <span>${appeal.topic}</span>
                            </div>
                            <div class="appeal-row">
                                <span class="label">Статус:</span>
                                <span>${appeal.status}</span>
                            </div>
                            <c:if test="${not empty appeal.content}">
                                <div class="appeal-row">
                                    <span class="label">Содержимое:</span>
                                    <span>${appeal.content}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty appeal.resolution}">
                                <div class="appeal-row">
                                    <span class="label">Резолюция:</span>
                                    <span>${appeal.resolution}</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty appeal.notes}">
                                <div class="appeal-row">
                                    <span class="label">Примечания:</span>
                                    <span>${appeal.notes}</span>
                                </div>
                            </c:if>
                        </div>
                        <div class="appeal-qr">
                            <img src="${qrCodes[appeal.id]}" alt="QR обращения">
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="no-appeals">
                <p>Нет рассмотренных заявлений для печати.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    let printRequested = false;

    function printDocuments() {
        window.addEventListener('beforeprint', function() {
            printRequested = true;
        });

        window.print();
    }

    function markAsPrinted() {
        document.getElementById('printForm').submit();
    }

    function toggleMenu() {
        document.body.classList.toggle("menu-open");
    }
</script>
</body>
</html>
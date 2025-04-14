<%--
  Created by IntelliJ IDEA.
  User: Fisp
  Date: 13.04.2025
  Time: 2:25
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Печать рассмотренных заявлений</title>
    <style>
        @media print {
            .no-print {
                display: none;
            }
            .appeal-card:not(:last-child) {
                page-break-after: always;
            }
        }
        .appeal-card {
            margin-bottom: 10px;
            padding: 10px;
        }
        .appeal-body {
            display: flex;
        }
        .appeal-info {
            flex: 1;
        }
        .appeal-qr {
            margin-left: 10px;
        }
        .label {
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="no-print">
    <h1>Печать рассмотренных заявлений</h1>

    <div class="print-controls">
        <a href="/admin/list" class="button back-button">Вернуться к списку</a>
        <button class="button" onclick="printDocuments()">Печать заявлений</button>
        <a href="/admin/download" class="button back-button">Скачать обращения</a>
    </div>

    <form id="printForm" action="/admin/mark-as-printed" method="post">
        <c:forEach items="${appeals}" var="appeal">
            <input type="hidden" name="ids" value="${appeal.id}">
        </c:forEach>
    </form>


</div>

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

<script>
    let printRequested = false;

    function printDocuments() {
        window.addEventListener('beforeprint', function() {
            printRequested = true;
        });

        window.addEventListener('afterprint', function() {
            if (printRequested) {
                document.getElementById('printForm').submit();
                printRequested = false;
            }
        });

        window.print();
    }
</script>
</body>
</html>

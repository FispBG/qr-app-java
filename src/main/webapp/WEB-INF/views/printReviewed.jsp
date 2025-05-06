<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<style>
    :root {
        --primary-blue: #1a73e8;
        --light-blue: #e8f0fe;
        --accent-color: #ff6b6b;
        --text-color: #333;
        --light-gray: #f5f5f5;
        --input-gray: #f0f0f0;
        --border-radius: 8px;
        --box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        --box-shadow-hover: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

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
    /* Layout Containers               */
    /* ======================================== */
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    /* ======================================== */
    /* Button Styles                   */
    /* ======================================== */
    .btn,
    .download-link,
    .print-button {
        display: inline-block;
        width: 220px !important;
        padding: 10px 0;
        text-align: center;
        border: none;
        border-radius: var(--border-radius);
        font-size: 16px;
        font-weight: normal;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: var(--box-shadow);
        text-decoration: none;
        margin: 0 10px;
        box-sizing: border-box;
    }

    .btn:hover,
    .download-link:hover,
    .print-button:hover {
        transform: translateY(-2px);
        box-shadow: var(--box-shadow-hover);
    }

    .btn-secondary {
        background-color: #6c757d;
        color: white;
    }

    .btn-secondary:hover {
        background-color: #5a6268;
    }

    .download-link {
        background-color: var(--primary-blue);
        color: white;
    }

    .download-link:hover {
        background-color: #0d62d0;
    }

    .print-button {
        background-color: #6c757d;
        color: white;
        margin: 15px 10px;
    }

    .print-button:hover {
        background-color: #5a6268;
    }

    /* ======================================== */
    /* Controls Container              */
    /* ======================================== */
    .controls-container {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }

    /* ======================================== */
    /* Appeal Card Styles             */
    /* ======================================== */
    .appeal-card {
        margin-bottom: 30px;
        padding: 20px;
        background-color: white;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
        page-break-inside: avoid;
    }

    .appeal-header {
        font-size: 1.2em;
        font-weight: bold;
        color: var(--accent-color);
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }

    .appeal-body {
        display: flex;
        gap: 20px;
    }

    .appeal-info {
        flex: 1;
    }

    .appeal-row {
        margin-bottom: 10px;
    }

    .appeal-row .label {
        font-weight: bold;
        color: var(--text-color);
        display: inline-block;
        width: 120px;
    }

    .appeal-qr {
        padding: 15px;
        background-color: var(--light-blue);
        border-radius: var(--border-radius);
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .appeal-qr img {
        width: 150px;
        height: 150px;
        display: block;
    }

    .no-appeals {
        text-align: center;
        padding: 50px;
        background-color: white;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
    }

    /* ======================================== */
    /* Print Styles                    */
    /* ======================================== */
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
        .btn,
        .download-link,
        .print-button,
        .controls-container {
            display: none !important;
        }

        .container {
            max-width: 100% !important;
            margin: 0 !important;
            padding: 0 !important;
            box-shadow: none !important;
            border: none !important;
        }

        .appeal-card {
            box-shadow: none !important;
            border: 1px solid #ccc;
            margin-bottom: 20mm;
            padding: 10mm;
        }

        .appeal-card:not(:last-child) {
            page-break-after: always;
        }

        .appeal-body {
            display: block;
        }

        .appeal-qr {
            background-color: transparent;
            padding: 0;
            margin-top: 10mm;
        }

        .appeal-qr img {
            border: 1px solid #ccc;
        }
    }
</style>
<head>
    <meta charset="UTF-8">
    <title>Печать рассмотренных заявлений</title>
</head>
<body>
<a href="/admin/list" class="btn btn-secondary">Обратно в меню</a>
<div class="container">
    <h1 class="no-print">Печать рассмотренных заявлений</h1>

    <div class="controls-container no-print">
        <a href="/admin/download?idOffice=${office}&id=${0}" class="download-link print-button">Скачать обращения</a>
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
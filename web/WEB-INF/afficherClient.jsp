<%--
  Created by IntelliJ IDEA.
  User: JORGE
  Date: 2/16/2020
  Time: 1:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Affichage d'un client</title>
    <link type="text/css" rel="stylesheet" href="<c:url value="/inc/style.css"/>"/>
</head>
<body>
<c:import url="/inc/menu.jsp"/>
<div id="corps">
    <p class="info">${ requestScope.form.resultat }</p>

    <p>Nom : <c:out value="${ requestScope.client.nom }"/></p>
    <p>Prénom : <c:out value="${ requestScope.client.prenom }"/></p>
    <p>Adresse : <c:out value="${ requestScope.client.adresse }"/></p>
    <p>Numéro de téléphone : <c:out value="${ requestScope.client.telephone }"/></p>
    <p>Email : <c:out value="${ requestScope.client.email }"/></p>
</div>
</body>
</html>

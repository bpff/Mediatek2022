<%@ page import="mediatek2022.Document" %><%--
  Created by IntelliJ IDEA.
  User: Elyes
  Date: 27/02/2022
  Time: 17:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

</head>
<body>
<%
    String nomUtilisateur = (String) request.getAttribute("nomUser");
    Document tt = (Document) request.getAttribute("document3");
    String docs = (String) request.getAttribute("tousLesDocs");
%>
</body>
<h2 style="color: aqua">Le nom de l'utilisateur est : <%=nomUtilisateur%></h2>
<h3 style="color:aquamarine;">Le document numero 3 est le suivant : <%=tt.toString()%></h3>
<h3 style="color: darkgoldenrod;">Tous les docs sont : <%=docs%></h3>

</html>

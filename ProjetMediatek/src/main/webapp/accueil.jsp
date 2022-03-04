<%@ page import="mediatek2022.Mediatheque" %>
<%@ page import="javax.print.Doc" %>
<%@ page import="mediatek2022.Document" %>
<%--
  Created by IntelliJ IDEA.
  User: Elyes
  Date: 25/02/2022
  Time: 21:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Mediatek2022</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
<% Mediatheque data = Mediatheque.getInstance(); String login = request.getParameter("login");
    String password = request.getParameter("password"); %>
<h1>Test de connexion user</h1>
<h1>Bonjour : <%= data.getUser(login,password).name() %> </h1>
<% StringBuilder toto = new StringBuilder();int cmp = 0;
for(Document d : data.tousLesDocumentsDisponibles()){
    toto.append(d.toString()).append(" ");
}%>

<h2><%=toto%> Ahah</h2>
<%Document tt = data.getDocument(3);%>
<h3 style="color:red"><%=tt.toString()%></h3>

</body>
</html>

<%@ page import="mediatek2022.Utilisateur" %>
<%@ page import="javax.rmi.CORBA.Util" %>
<%@ page import="mediatek2022.Document" %><%--
  Created by IntelliJ IDEA.
  User: Elyes
  Date: 27/02/2022
  Time: 21:04
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
    Utilisateur u = (Utilisateur) request.getSession().getAttribute("profil");
    String nomUtilisateur="";
    if(u == null){
        response.sendRedirect("index.jsp");
    }
    else {
         nomUtilisateur= (String) request.getAttribute("nomUser");
        System.out.println(u);
    }

%>

<h2 style="color: firebrick">Le nom de l'utilisateur est : <%=nomUtilisateur%></h2>
<h3>Bienvenue dans la médiathèque</h3>
<%
   boolean biblio = (boolean) request.getAttribute("bibliothecaire");
   String bbb = biblio ? "bibliothécaire" : "abonné";
%>
<% if(biblio){%>
<h2 style="color: darkcyan"><%=nomUtilisateur%> est un <%=bbb%></h2>
<h3>Vous avez donc le droit d'ajouter des documents dans la médiathèque</h3>
<form action="${pageContext.request.contextPath}/AjoutDocument" method="post">
    <div class="form-group">
        <label for="type">Select list:</label>
        <select class="form-control" id="type" name="type">
            <option value="CD">CD</option>
            <option value="DVD">DVD</option>
            <option value="Livre">Livre</option>
        </select>
    </div>
    <div class="form-group">
        <label for="titre">Titre</label>
        <input type="text" class="form-control" id="titre" name="titre" placeholder="Titre du document">
    </div>
    <div class="form-group">
        <label for="auteur">Auteur</label>
        <input type="text" class="form-control" id="auteur" name="auteur" placeholder="Auteur du document">
    </div>
    <button type="submit" class="btn btn-primary">Connexion</button>
</form>
<% }else{%>
<h2 style="color: lemonchiffon;"><%=nomUtilisateur%> est un <%=bbb%></h2>
<h3>Vous pouvez donc choisir d'emprunter des documents ou alors de retourner un des documents empruntés</h3>
<h3>Voici tous les documents proposés dans la médiathèque.</h3>
<%

    Document tt = (Document) request.getAttribute("document3");
    String docs = (String) request.getAttribute("tousLesDocs");
%>
<h3 style="color: darkgoldenrod;"><%=docs%></h3>
<h3>Voici le document 3</h3>
<h3 style="color: darkgoldenrod;"><%=tt%></h3>
<%if(tt.disponible()){%>
<h3>Le livre est DISPO</h3><%}else{%>
<h3>Le livre n'est pas dispo</h3>
<%}}%>

</body>
<%--<h2 style="color: aqua">Le nom de l'utilisateur est : <%=nomUtilisateur%></h2>--%>
<%--<h3 style="color:aquamarine;">Le document numero 3 est le suivant : <%=tt.toString()%></h3>--%>
<%--<h3 style="color: darkgoldenrod;">Tous les docs sont : <%=docs%></h3>--%>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>

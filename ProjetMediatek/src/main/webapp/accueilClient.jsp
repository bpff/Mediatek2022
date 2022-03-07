        <%@ page import="mediatek2022.Utilisateur" %>
<%@ page import="javax.rmi.CORBA.Util" %>
<%@ page import="mediatek2022.Document" %>
<%@ page import="java.util.Arrays" %>
        <%@ page import="mediatek2022.Mediatheque" %><%--
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
    String nomUtilisateur = "";
    if (u == null) {
        response.sendRedirect("index.jsp");
    } else {
        nomUtilisateur = (String) request.getAttribute("nomUser");
        System.out.println(u);
    }

%>

<h2 style="color: firebrick">Le nom de l'utilisateur est : <%=nomUtilisateur%></h2>
<h3>Bienvenue dans la médiathèque</h3>
<%
    boolean biblio = (boolean) request.getAttribute("bibliothecaire");
    String bbb = biblio ? "bibliothécaire" : "abonné";
%>
<% String dee;
    if (biblio) {%>
<h2 style="color: darkcyan"><%=nomUtilisateur%> est un <%=bbb%></h2>
<h3>Vous avez donc le droit d'ajouter des documents dans la médiathèque</h3>
<form action="${pageContext.request.contextPath}/AjoutDocument" method="post">
    <div class="col-md-4">
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
    </div>
</form>
<% } else {%>
<h2 style="color: lemonchiffon;"><%=nomUtilisateur%> est un <%=bbb%></h2>
<h3>Vous pouvez donc choisir d'emprunter des documents ou alors de retourner un des documents empruntés</h3>
<h3>Voici tous les documents proposés dans la médiathèque.</h3>
<%

    Document tt = (Document) request.getAttribute("document3");
    StringBuilder totoo = new StringBuilder();
    for (Document dd : Mediatheque.getInstance().tousLesDocumentsDisponibles()) {
        totoo.append(dd.toString()).append("");
    }
%>
<h3 style="color: darkgoldenrod;"></h3>
<h3><%String[] toto = totoo.toString().split("}");%></h3>
<table class="table table-striped">
    <thead>
    <tr>
        <th scope="col">#</th>
        <th scope="col">Titre</th>
        <th scope="col">idDocument</th>
        <th scope="col">Disponible</th>
        <th scope="col">idEmprunteur</th>
        <th scope="col">Type Document</th>
        <th scope="col">Auteur</th>
        <th scope="col">Emprunter</th>
    </tr>
    </thead>
    <tbody>
    <%
        String[] tousLesLivres= totoo.toString().split("}");
        System.out.println(Arrays.toString(tousLesLivres));
        String[] chaqueTitre = new String[tousLesLivres.length];
        int[] chaqueId = new int[tousLesLivres.length];
        String[] chaqueDisponible = new String[tousLesLivres.length];
        String[] chaqueEmprunteur = new String[tousLesLivres.length];
        String[] chaqueType = new String[tousLesLivres.length];
        String[] chaqueAuteur = new String[tousLesLivres.length];

        for(int i=0;i< tousLesLivres.length;i++){
            System.out.println(tousLesLivres[i].split(",")[0].split("=")[1]);
            chaqueTitre[i] = tousLesLivres[i].split(",")[0].split("=")[1];
            chaqueId[i] = Integer.parseInt(tousLesLivres[i].split(",")[1].split("=")[1]);
            chaqueDisponible[i] = tousLesLivres[i].split(",")[2].split("=")[1];
            chaqueEmprunteur[i] = tousLesLivres[i].split(",")[3].split("=")[1];
            chaqueType[i] = tousLesLivres[i].split(",")[4].split("=")[1];
            chaqueAuteur[i] = tousLesLivres[i].split(",")[5].split("=")[1];

        }
        System.out.println(chaqueTitre[0] + chaqueId[0] + chaqueDisponible[0] + chaqueEmprunteur[0] + chaqueType[0] + chaqueAuteur[0]);

        for (int i=0;i< tousLesLivres.length;i++){
    %>
    <tr>
        <th scope="row"><%=i%></th>
        <td><%=chaqueTitre[i]%></td>
        <td><%=chaqueId[i]%></td>
        <td><%=chaqueDisponible[i]%></td>
        <td><%=chaqueEmprunteur[i]%></td>
        <td><%=chaqueType[i]%></td>
        <td><%=chaqueAuteur[i]%></td>
        <td><form action="${pageContext.request.contextPath}/Emprunt" method="post">
            <input id="hidden" name="idDocAEmprunter" value=<%=chaqueId[i]%> type="hidden" >
            <button type="submit" class="btn btn-primary">Emprunter</button>
        </form></td>
    </tr>
    <%}%>
    </tbody>
</table>
<h3>Voici le document 3</h3>
<h3 style="color: darkgoldenrod;"><%=tt%></h3>
<%if (tt.disponible()) {%>
<h3>Le livre est DISPO</h3><%} else {%>
<h3>Le livre n'est pas dispo</h3>
<%}
    tt.retour();%>
<h3><%=tt%></h3><%
    try {
        tt.emprunt(u);
    } catch (Exception e) {
        e.printStackTrace();
    }
%><%}%>

</body>
<%--<h2 style="color: aqua">Le nom de l'utilisateur est : <%=nomUtilisateur%></h2>--%>

<%--<h3 style="color:aquamarine;">Le document numero 3 est le suivant : <%=tt.toString()%></h3>--%>
<%--<h3 style="color: darkgoldenrod;">Tous les docs sont : <%=docs%></h3>--%>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>

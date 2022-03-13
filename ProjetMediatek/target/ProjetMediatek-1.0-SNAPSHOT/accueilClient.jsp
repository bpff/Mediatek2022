<%@ page import="mediatek2022.Utilisateur" %>
<%@ page import="mediatek2022.Document" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="mediatek2022.Mediatheque" %>

<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: Elyes
  Date: 27/02/2022
  Time: 21:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="fr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Accueil - Mediatek</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i">
    <link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="assets/js/creative.js"></script>

</head>

<body id="page-top" data-bs-spy="scroll" data-bs-target="#mainNav" data-bs-offset="57">
<%
    Utilisateur u = (Utilisateur) request.getSession().getAttribute("profil");
    String nomUtilisateur = "";
    if (u == null) {
        response.sendRedirect("index.jsp");
    } else {
        nomUtilisateur = u.name();
        System.out.println(u);
    }
    boolean biblio = (boolean) request.getSession().getAttribute("bibliothecaire");
    String bibliothecaire = biblio ? "bibliothécaire" : "abonné";

%>
<nav class="navbar navbar-light navbar-expand-lg bg-black" id="mainNav">
    <div class="container"><a class="navbar-brand">Mediatek2022</a><button data-bs-toggle="collapse" data-bs-target="#navbarResponsive" class="navbar-toggler navbar-toggler-right" type="button" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><i class="fa fa-align-justify"></i></button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
                <%--                <li class="nav-item"><a class="nav-link" href="#about">About</a></li>--%>
                <%--                <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>--%>
                    <li class="nav-item"><a class="nav-link">Bienvenue <%=nomUtilisateur%></a></li>
                <li class="nav-item"><a class="nav-link">Espace <%=bibliothecaire%></a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/Deconnexion">Deconnexion</a></li>
            </ul>
        </div>
    </div>
</nav>
<%--<form action="${pageContext.request.contextPath}/Deconnexion" method="post">--%>
<%--    <button type="submit" class="btn btn-primary">Deconnexion</button>--%>
<%--</form>--%>
<%if (biblio) {%>
<h3 class="text-center text-muted">Bienvenue dans l'espace bibliothécaire, vous pouvez ajouter des documents dans la médiathèque pour proposer plus de contenu à nos abonnés.</h3>
<hr>
<div class="container">
    <div class="row justify-content-md-center">
        <div class="col col-md-6">
            <form action="${pageContext.request.contextPath}/AjoutDocument" method="post">
                <div class="form-group align-content-center">
                    <label for="type">Choisissez le type du document à ajouter:</label>
                    <select class="form-control" id="type" name="type">
                        <option value="CD">CD</option>
                        <option value="DVD">DVD</option>
                        <option value="Livre">Livre</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="titre">Titre</label>
                    <input type="text" class="form-control" id="titre" name="titre" placeholder="Titre du document" required="required">
                </div>
                <div class="form-group">
                    <label for="auteur">Auteur</label>
                    <input type="text" class="form-control" id="auteur" name="auteur" placeholder="Auteur du document" required="required">
                </div>
                <button type="submit" class="btn btn-primary text-capitalize">Ajouter</button>
            </form>
        </div>
    </div>
</div>

<% String messageErreur = request.getAttribute("erreur") != null ? (String) request.getAttribute("erreur") : "";
    String erreur = "";
    if (messageErreur.length() > 0) {
        erreur = messageErreur;
    }%>
<% String success = request.getAttribute("succes") != null ? (String) request.getAttribute("succes") : "";
    String reussite = "";
    if (success.length() > 0) {
        reussite = success;
    }%>
<% String reussiteErreur = erreur.length() > 0 ? erreur : reussite;%>
<h4 class="text-muted text-center"><%=reussiteErreur%></h4>
<% } else {%>
</h2>
<h3 class="text-center text-dark ">Bienvenue dans l'espace abonné, vous pouvez consulter les documents disponibles et les emprunter ou bien retourner un de vos documents empruntés.</h3>
<hr class="my-4">

<%
    StringBuilder tousLesDocsEmpruntables = new StringBuilder();
    ArrayList<Document> tousLesDocs = (ArrayList<Document>) Mediatheque.getInstance().tousLesDocumentsDisponibles();
    for (Document dd : tousLesDocs) {
        tousLesDocsEmpruntables.append(dd.toString());
    }
    if(tousLesDocs.isEmpty()){
%>
<h5 class="text-muted text-center">Aucun document n'est malheureusement disponible pour le moment, mais n'hésitez pas à revenir de temps en temps, il y a souvent du nouveau</h5>
<%}else{%>
<h5 class="text-center text-muted">Voici tous les documents proposés dans la médiathèque.</h5>
<div class="container-fluid">
    <div class="row row-flex ">
        <div class="col-xs-4 col-sm-6 col-md-10 col-lg-12 my-auto">
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
        String[] tousLesLivres = tousLesDocsEmpruntables.toString().split("}");
        System.out.println(Arrays.toString(tousLesLivres));
        String[] chaqueTitre = new String[tousLesLivres.length];
        int[] chaqueId = new int[tousLesLivres.length];
        String[] chaqueDisponible = new String[tousLesLivres.length];
        String[] chaqueEmprunteur = new String[tousLesLivres.length];
        String[] chaqueType = new String[tousLesLivres.length];
        String[] chaqueAuteur = new String[tousLesLivres.length];

        for (int i = 0; i < tousLesLivres.length; i++) {
            System.out.println(tousLesLivres[i].split(",")[0].split("=")[1]);
            chaqueTitre[i] = tousLesLivres[i].split(",")[0].split("=")[1];
            chaqueId[i] = Integer.parseInt(tousLesLivres[i].split(",")[1].split("=")[1]);
            chaqueDisponible[i] = tousLesLivres[i].split(",")[2].split("=")[1];
            chaqueEmprunteur[i] = tousLesLivres[i].split(",")[3].split("=")[1];
            chaqueType[i] = tousLesLivres[i].split(",")[4].split("=")[1];
            chaqueAuteur[i] = tousLesLivres[i].split(",")[5].split("=")[1];

        }
        for (int i = 0; i < tousLesLivres.length; i++) {
    %>
    <tr>
        <th scope="row"><%=i%>
        </th>
        <td><%=chaqueTitre[i]%>
        </td>
        <td><%=chaqueId[i]%>
        </td>
        <td><%=chaqueDisponible[i]%>
        </td>
        <td><%=chaqueEmprunteur[i]%>
        </td>
        <td><%=chaqueType[i]%>
        </td>
        <td><%=chaqueAuteur[i]%>
        </td>
        <td>
            <form action="${pageContext.request.contextPath}/Emprunt" method="post">
                <input id="hidden" name="idDocAEmprunter" value=<%=chaqueId[i]%> type="hidden">
                <button type="submit" class="btn btn-primary btn-sm text-capitalize">Emprunter</button>
            </form>
        </td>
    </tr>
    <%}%>
    </tbody>
</table>
        </div>
    </div>
</div>
<hr>
<%}%>
<%
    ArrayList<Document> listeDocsUser = (ArrayList<Document>) u.data()[1];
    StringBuilder tousleslivresusers = new StringBuilder();
    for (Document d : listeDocsUser) {
        tousleslivresusers.append(d);
    }
    if(listeDocsUser.isEmpty()){
%>
<h5 class="text-center text-muted">Vous n'avez pas encore loué de documents, qu'attendez vous ?</h5>
<%}else{%>
<h5 class="text-center text-muted">Voici la liste de vos documents</h5>
<div class="container-fluid">
    <div class="row row-flex ">
        <div class="col-xs-4 col-sm-6 col-md-10 col-lg-12 my-auto">
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
        String[] tousLesLivresUser = tousleslivresusers.toString().split("}");
        System.out.println(Arrays.toString(tousLesLivresUser));
        String[] chaqueTitreuser = new String[tousLesLivresUser.length];
        int[] chaqueIdUser = new int[tousLesLivresUser.length];
        String[] chaqueDisponibleUser = new String[tousLesLivresUser.length];
        String[] chaqueEmprunteurUser = new String[tousLesLivresUser.length];
        String[] chaqueTypeUser = new String[tousLesLivresUser.length];
        String[] chaqueAuteurUser = new String[tousLesLivresUser.length];

        for (int i = 0; i < tousLesLivresUser.length; i++) {
            System.out.println(tousLesLivresUser[i].split(",")[0].split("=")[1]);
            chaqueTitreuser[i] = tousLesLivresUser[i].split(",")[0].split("=")[1];
            chaqueIdUser[i] = Integer.parseInt(tousLesLivresUser[i].split(",")[1].split("=")[1]);
            chaqueDisponibleUser[i] = tousLesLivresUser[i].split(",")[2].split("=")[1];
            chaqueEmprunteurUser[i] = tousLesLivresUser[i].split(",")[3].split("=")[1];
            chaqueTypeUser[i] = tousLesLivresUser[i].split(",")[4].split("=")[1];
            chaqueAuteurUser[i] = tousLesLivresUser[i].split(",")[5].split("=")[1];

        }
        for (int i = 0; i < tousLesLivresUser.length; i++) {
    %>
    <tr>
        <th scope="row"><%=i%>
        </th>
        <td><%=chaqueTitreuser[i]%>
        </td>
        <td><%=chaqueIdUser[i]%>
        </td>
        <td><%=chaqueDisponibleUser[i]%>
        </td>
        <td><%=chaqueEmprunteurUser[i]%>
        </td>
        <td><%=chaqueTypeUser[i]%>
        </td>
        <td><%=chaqueAuteurUser[i]%>
        </td>
        <td>
            <form action="${pageContext.request.contextPath}/Retour" method="post">
                <input id="hiddenBis" name="idDocARetourner" value=<%=chaqueIdUser[i]%> type="hidden">
                <button type="submit" class="btn btn-primary btn-sm text-capitalize">Retourner</button>
            </form>
        </td>
    </tr>
    <%}%>
    </tbody>
</table>
        </div>
    </div>
</div>
<%}%>
<%}%>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>
</html>

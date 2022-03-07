<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mediatek</title>
    <meta charset="UTF-8">

    <link rel="stylesheet" type="text/css" href="./assets/css/login.css">

</head>
<div class="login-box">
    <h2>Bienvenue Ã  la mediatek ! </h2>
    <form action="${pageContext.request.contextPath}/Authentification" method="post" name ="ConnexionForm">
        <div class="user-box">
            <input type="text" class="form-control" id="name" name="login" aria-describedby="login" placeholder="Entrez votre login">
            <label>Login</label>
            <% String messageErreur = request.getAttribute("erreurUtilisateur") !=null ? (String) request.getAttribute("erreurUtilisateur") : "";
                String erreur="";
                if(messageErreur.length()>0){
                    erreur = messageErreur;
                }%>
            <small id="loginHelp" class="form-text text-muted" style="color: red"><%=erreur%></small>
        </div>
        <div class="user-box">
            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
            <label>Mot de passe</label>
        </div>
        <a href="#" onclick="document.ConnexionForm.submit();">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            Connexion
        </a>
        <button type="submit" name="cache" id="cancel" hidden="hidden"></button>
    </form>
</div>
</html>
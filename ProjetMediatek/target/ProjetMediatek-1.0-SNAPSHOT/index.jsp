<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <%--    <link rel="stylesheet" href="./assets/css/style.css">--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
<h2><%= "Hello World!" %>
</h2>
<br/>
<h3> Bienvenue dans la Mediatek, veuillez vous authentifier</h3>
<div class="container">
    <div class="row justify-content-md-center">
        <div class="col col-md-4">
            <form action="${pageContext.request.contextPath}/Authentification" method="post">
                <div class="form-group">
                    <label for="name">Login</label>
                    <input type="text" class="form-control" id="name" name="login" aria-describedby="login" placeholder="Entrez votre login">
                    <% String messageErreur = request.getAttribute("erreurUtilisateur") !=null ? (String) request.getAttribute("erreurUtilisateur") : "";
                        String erreur="";
                        if(messageErreur.length()>0){
                            erreur = messageErreur;
                        }%>
                    <small id="loginHelp" class="form-text text-muted" style="color: red"><%=erreur%></small>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                </div>
                <button type="submit" class="btn btn-primary">Connexion</button>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
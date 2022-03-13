<!DOCTYPE html>
<html lang="fr">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Connexion - Mediatek</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i">
    <link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
    <link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
    <link rel="stylesheet" href="assets/css/Form.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="assets/js/creative.js"></script>
</head>

<body id="page-top" data-bs-spy="scroll" data-bs-target="#mainNav" data-bs-offset="57">
<nav class="navbar navbar-light navbar-expand-lg fixed-top" id="mainNav">
    <div class="container"><a class="navbar-brand">Mediatek2022</a><button data-bs-toggle="collapse" data-bs-target="#navbarResponsive" class="navbar-toggler navbar-toggler-right" type="button" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><i class="fa fa-align-justify"></i></button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link">Connectez-vous !</a></li>
                <li class="nav-item"><a class="nav-link" ></a></li>
            </ul>
        </div>
    </div>
</nav>
<header class="text-center text-white d-flex masthead" style="background-image:url('assets/img/header.jpg');">
    <div class="container my-auto">
        <div class="row">
            <div class="col-lg-10 mx-auto">
                <h1 class="text-uppercase"><strong>Bienvenue sur la mediatek</strong></h1>
                <hr>
            </div>
        </div>
        <div class="col-lg-8 mx-auto">
            <p class="text-faded mb-5">Veuillez vous connecter si vous souhaitez acc&eacute;der  &agrave; votre compte au sein de la mediatek</p>
            <form action="${pageContext.request.contextPath}/Authentification" method="post">
                <h1 style="font-size: 20px;margin-bottom: 15px;border-color: var(--bs-indigo);"><i class="icon-user" style="color: #00baff;padding-right: 15px;"></i>Account information</h1>
                <div class="form-group">
                    <label for="name">Login</label>
                    <input type="text" class="border rounded-0 form-control" style="width: 500px;margin: 0 18.5% 15px;height: 35px;padding: 0 12px;" id="name" name="login" aria-describedby="login"
                           placeholder="Entrez votre login">
                    <% String messageErreur = request.getAttribute("erreurUtilisateur") != null ? (String) request.getAttribute("erreurUtilisateur") : "";
                        String erreur = "";
                        if (messageErreur.length() > 0) {
                            erreur = messageErreur;
                        }%>
                    <small id="loginHelp" class="form-text text-white text-center" style="color: white"><%=erreur%>
                    </small>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="border rounded-0 form-control" style="width: 500px;margin: 0 18.5% 15px;height: 35px;padding: 0 12px;" id="password" name="password" placeholder="Password">
                </div>
                <button class="btn btn-primary" type="submit" style="width: 500px;/*margin-right: 0px;*/margin-left: 9%;background-color: #00baff;">Connexion</button>
            </form>
        </div>
    </div>
</header>
<section id="portfolio" class="p-0"></section>
<script src="assets/bootstrap/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
<script src="assets/js/creative.js"></script>
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
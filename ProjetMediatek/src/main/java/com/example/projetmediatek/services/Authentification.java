package com.example.projetmediatek.services;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mediatek2022.Document;
import mediatek2022.Mediatheque;
import mediatek2022.Utilisateur;

/**
 * Servlet implementation class ServlerRechercheLivres
 */

@WebServlet(name = "AuthentificationUtilisateur", value = "/Authentification")
public class Authentification extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Authentification() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Mediatheque data = Mediatheque.getInstance();
        HttpSession session = request.getSession(true);
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        Utilisateur u = data.getUser(login,password);

       // System.out.println("ESSAI de l'ajout du document");
       // data.ajoutDocument(2,"Coucou",true,"ElyesMimo");
        String erreur;
        if(u == null){
            erreur = "L'utilisateur " + login +" n'a pas été trouvé ou le mot de passe est incorrect.";
            request.setAttribute("nomUser", login);
            request.setAttribute("erreurUtilisateur",erreur);
            RequestDispatcher d = request.getRequestDispatcher("index.jsp");
            d.forward(request, response);
        }else{
            session.setAttribute("profil",u);
            session.isNew();
            Document tt = data.getDocument(14);
            StringBuilder toto = new StringBuilder();
            for (Document dd : data.tousLesDocumentsDisponibles()) {
                toto.append(dd.toString()).append(" ");
            }
            String nomUtilisateur = u.name();
            boolean bibliothecaire = u.isBibliothecaire();
            request.setAttribute("bibliothecaire",bibliothecaire);
            request.setAttribute("nomUser", nomUtilisateur);
            request.setAttribute("document3", tt);
            request.setAttribute("tousLesDocs", toto.toString());
            RequestDispatcher d = request.getRequestDispatcher("accueilClient.jsp");
            d.forward(request, response);
        }
    }
}

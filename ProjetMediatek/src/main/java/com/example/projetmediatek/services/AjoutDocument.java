package com.example.projetmediatek.services;

import mediatek2022.Mediatheque;
import mediatek2022.Utilisateur;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


/**
 * Servlet implementation class ServlerRechercheLivres
 */

@WebServlet(name = "AjoutDocument", value = "/AjoutDocument")
public class AjoutDocument extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjoutDocument() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession(true).getAttribute("profil");
        if (user == null || user.toString().equals("")) {
            resp.sendRedirect(req.getContextPath() + "/Authentification");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Mediatheque data = Mediatheque.getInstance();
        String titre = request.getParameter("titre");
        String auteur = request.getParameter("auteur");
        String type = request.getParameter("type");
        System.out.println(type +" " + auteur + " " + titre);
        int typeDoc;
        switch (type) {
            case "Livre":
                typeDoc = 1;
                break;
            case "DVD":
                typeDoc = 2;
                break;
            case "CD":
                typeDoc = 3;
                break;
            default:
                typeDoc = 4;
        }
        boolean invalide = false;
        String erreur = "";
        String success = "";
        if (titre == null || auteur == null || titre.length() == 0 || titre.length() == 0) {
            invalide = true;
        }
        if (invalide) {
            erreur = "Veuillez remplir tous les champs";
            request.setAttribute("erreur", erreur);
            RequestDispatcher d = request.getRequestDispatcher("accueilClient.jsp");
            d.forward(request, response);
        } else {
            data.ajoutDocument(typeDoc, titre, true, auteur);
            success = type + " " + titre + " ajouté avec succès dans la médiathèque";
            request.setAttribute("succes", success);
            RequestDispatcher d = request.getRequestDispatcher("accueilClient.jsp");
            d.forward(request, response);
        }
    }
}

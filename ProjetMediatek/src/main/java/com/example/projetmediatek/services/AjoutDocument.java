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

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Mediatheque data = Mediatheque.getInstance();
        HttpSession session = request.getSession(true);
        String titre = request.getParameter("titre");
        String auteur = request.getParameter("auteur");
        String type = request.getParameter("type");
        System.out.println(type+ auteur+ titre);
        int typeDoc;
        switch (type){
            case "Livre" :
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
        data.ajoutDocument(typeDoc,titre,true,auteur);


        // System.out.println("ESSAI de l'ajout du document");
        // data.ajoutDocument(2,"Coucou",true,"ElyesMimo");
            RequestDispatcher d = request.getRequestDispatcher("accueilClient.jsp");
            d.forward(request, response);
        }
    }

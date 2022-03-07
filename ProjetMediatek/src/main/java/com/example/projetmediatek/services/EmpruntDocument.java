package com.example.projetmediatek.services;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.rmi.CORBA.Util;
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

@WebServlet(name = "EmpruntDocument", value = "/Emprunt")
public class EmpruntDocument extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmpruntDocument() {
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
        int iDdocEmprunt = Integer.parseInt(request.getParameter("idDocAEmprunter"));
        System.out.println(request.getParameter("idDocAEmprunter"));
        Utilisateur u = (Utilisateur) session.getAttribute("profil");
        System.out.println(u+" c'est lutilisateur");
        Document dd = data.getDocument(iDdocEmprunt);
        try {
            dd.emprunt(u);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(dd);

        RequestDispatcher d = request.getRequestDispatcher("accueilClient.jsp");
        d.forward(request, response);
    }
}

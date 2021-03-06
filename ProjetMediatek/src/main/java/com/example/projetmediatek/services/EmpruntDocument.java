package com.example.projetmediatek.services;

import mediatek2022.Document;
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("profil");
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
        HttpSession session = request.getSession(true);
        int iDdocEmprunt = Integer.parseInt(request.getParameter("idDocAEmprunter"));
        Utilisateur u = (Utilisateur) session.getAttribute("profil");
        System.out.println(u + " est l'utilisateur qui veut emprunter");
        Document document = data.getDocument(iDdocEmprunt);
        try {
            document.emprunt(u);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(document);
        RequestDispatcher d = request.getRequestDispatcher("accueilClient.jsp");
        d.forward(request, response);
    }
}

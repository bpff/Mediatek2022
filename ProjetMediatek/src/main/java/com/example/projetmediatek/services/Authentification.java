package com.example.projetmediatek.services;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = (String) req.getSession(true).getAttribute("profil");
        if (user == null || user.equals("")) {
            RequestDispatcher d = req.getRequestDispatcher("index.jsp");
            d.forward(req,resp);
        }

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
        String erreur;
        if(u == null){
            erreur = "L'utilisateur " + login +" n'a pas été trouvé ou le mot de passe est incorrect.";
            request.setAttribute("nomUser", login);
            request.setAttribute("erreurUtilisateur",erreur);
            RequestDispatcher d = request.getRequestDispatcher("index.jsp");
            d.forward(request, response);
        }else{
            session.setAttribute("profil",u);
            RequestDispatcher d = request.getRequestDispatcher("accueilClient.jsp");
            d.forward(request, response);
        }
    }
}

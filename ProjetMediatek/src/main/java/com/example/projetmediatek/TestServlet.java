package com.example.projetmediatek;

import java.io.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;
import mediatek2022.Document;
import mediatek2022.Mediatheque;
import mediatek2022.Utilisateur;

/**
 * Servlet implementation class ServlerRechercheLivres
 */

@WebServlet(name = "testAccueil", value = "/AccueilServlet")
public class TestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Mediatheque data = Mediatheque.getInstance();
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        String userName = data.getUser(login, password).name();
        Document tt = data.getDocument(3);
        StringBuilder toto = new StringBuilder();
        for (Document dd : data.tousLesDocumentsDisponibles()) {
            toto.append(dd.toString()).append(" ");
        }
            request.setAttribute("nomUser", userName);
            request.setAttribute("document3", tt);
            request.setAttribute("tousLesDocs", toto.toString());

            RequestDispatcher d = request.getRequestDispatcher("testAccueil.jsp");
            d.forward(request, response);


    }
}

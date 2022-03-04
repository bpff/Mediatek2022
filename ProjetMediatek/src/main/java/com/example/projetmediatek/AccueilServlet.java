package com.example.projetmediatek;

import mediatek2022.Mediatheque;

import java.io.*;
import java.net.URL;
import java.net.URLClassLoader;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "accueilServlet", value = "/accueil-servlet")
public class AccueilServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World! World   ";
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        response.setContentType("text/html");
//        // Hello
//        PrintWriter out = response.getWriter();
//        HttpSession session = request.getSession(true);
//        String login = request.getParameter("login");
//        String passwd = request.getParameter("password");
//        Mediatheque data = Mediatheque.getInstance();
//        out.println("<html><body>");
//        out.println("<h1>"+data.getUser(login,passwd).name()
//                +"</h1>");
//        out.println("</body></html>");
//        out.println("</body></html>");
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        response.setContentType("text/html"); 	 	//	format	du	contenu	de	la	réponse
        PrintWriter	out	=	response.getWriter();
        out.println("<html>"); 					//	générer	le	résultat	dynamique
        out.println("<body>");
        Mediatheque data = Mediatheque.getInstance();
        out.println("Salut, on fait un test");
        out.println("Bonjour " + data.getUser(login,password).name());
        out.println("</body>");
        out.println("</html>");
    }

    public void destroy() {
    }
}


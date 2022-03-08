package com.example.projetmediatek.persistance.utilisateur;

import com.example.projetmediatek.persistance.document.DocumentMediatek;
import mediatek2022.Document;
import mediatek2022.Utilisateur;

import javax.print.Doc;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Abonne implements Utilisateur {

    private int idUtilisateur;
    private String login;
    private String password;
    private int age;


    public Abonne(int idUtilisateur, String login, String password, int age) {
        this.idUtilisateur = idUtilisateur;
        this.login = login;
        this.password = password;
        this.age = age;
    }

    private PreparedStatement statement(String sql) throws SQLException, ClassNotFoundException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mediatek2022","root","root");
        return connection.prepareStatement(sql);
    }

    @Override
    public String toString() {
        return "Abonne{" +
                "idUtilisateur=" + idUtilisateur +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", age=" + age +
                ", bibliothécaire=" + isBibliothecaire() +
                '}';
    }

    @Override
    public String name() {
        return this.login;
    }

    @Override
    public boolean isBibliothecaire() {
        return false;
    }

    @Override
    public Object[] data() {
        Object[] tabInformationsUser = new Object[3];
        tabInformationsUser[0] = age;
        // Mise en place de la requête pour retourner la liste des documents de l'utilisateur
        PreparedStatement dispo = null;
        List<Document> listeDocsUtilisateur = new ArrayList<>();
        try{
            dispo = statement("Select * from document where idUtilsateurEmprunt = ?");
            dispo.setInt(1,this.idUtilisateur);
            System.out.println(this.login + " utilisateur accede à sa liste de documents");
            ResultSet tt = dispo.executeQuery();
            while(tt.next()){
                int idDoc = Integer.parseInt(tt.getString("idDocument"));
                String nom = tt.getString("titreDocument");
                String typeDoc = tt.getString("typeDocument");
                String auteur = tt.getString("auteur");
                Document document =   new DocumentMediatek(nom,idDoc,false,typeDoc,auteur,this.idUtilisateur);

                listeDocsUtilisateur.add(document);

            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        tabInformationsUser[1] = listeDocsUtilisateur;
        return tabInformationsUser;
    }
}

package com.example.projetmediatek.persistance.document;

import mediatek2022.Document;
import mediatek2022.Utilisateur;

import java.sql.*;

public class DocumentMediatek implements Document {
    private final String titre;
    private final int idDocument;
    private final boolean disponible;
    private final int idEmprunteur;
    private final String typeDoc;
    private final String auteur;
    private static Connection connection = null;


    public DocumentMediatek(String titre, int idDocument, boolean disponible, String typeDoc, String auteur, int idEmprunteur) {
        this.titre = titre;
        this.idDocument = idDocument;
        this.disponible = disponible;
        this.idEmprunteur = idEmprunteur;
        this.typeDoc = typeDoc;
        this.auteur = auteur;
    }

    private PreparedStatement statement(String sql) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        DocumentMediatek.connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mediatek2022", "root", "root");
        return DocumentMediatek.connection.prepareStatement(sql);
    }

    @Override
    public String toString() {
        return "titre=" + titre +
                ", idDocument=" + idDocument +
                ", disponible=" + disponible +
                ", idEmprunteur=" + idEmprunteur +
                ", typeDoc=" + typeDoc +
                ", auteur=" + auteur + "}";
    }

    @Override
    public boolean disponible() {
        PreparedStatement requeteDispo = null;
        boolean dispon = disponible;
        try {

                    requeteDispo = statement("Select * from document where idDocument = ?");
                    requeteDispo.setInt(1, this.idDocument);
                    System.out.println(this.idDocument + " id du doc " + this.titre);
            synchronized (DocumentMediatek.connection) {
                    ResultSet resultatRequete = requeteDispo.executeQuery();
                    if (!resultatRequete.next()) dispon = false;
                    dispon = resultatRequete.getBoolean("disponible");
                    System.out.println("Le " + typeDoc + " est " + dispon);
                }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return dispon;
    }

    @Override
    public void emprunt(Utilisateur u) throws Exception {
        // récupérer id de l'utilisateur et le stocker
        // disponible --> false
        // changer la valeur de null du document et y assigner l'id
        PreparedStatement recupIdAbo = null;
        PreparedStatement updateEmprunt = null;
        try {

                recupIdAbo = statement("Select idUtilisateur from utilisateur where login = ?");
                recupIdAbo.setString(1, u.name());
            synchronized (DocumentMediatek.connection) {
                ResultSet resultatRequete = recupIdAbo.executeQuery();
                if (!resultatRequete.next()) System.out.println("Rien ne se passe");
                int idAbo = resultatRequete.getInt("idUtilisateur");
                System.out.println(idAbo);
                updateEmprunt = statement("Update document set disponible = ?, idUtilsateurEmprunt = ? where idDocument = ?");
                updateEmprunt.setBoolean(1, false);
                updateEmprunt.setInt(2, idAbo);
                updateEmprunt.setInt(3, this.idDocument);
                updateEmprunt.executeUpdate();
            }
                System.out.println(u + " a emprunté " + this);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void retour() {
        PreparedStatement req = null;
        try {

                req = statement("UPDATE document SET disponible = true, idUtilsateurEmprunt = null WHERE" +
                        " idDocument = ? ");
                req.setInt(1, this.idDocument);
            synchronized (DocumentMediatek.connection) {
                int resultat = req.executeUpdate();

                String result = resultat == 1 ? "Retour effectué" : "Retour non effectué : problème pour le livre " + this;
                System.out.println(resultat + " " + result);
                req.close();
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}

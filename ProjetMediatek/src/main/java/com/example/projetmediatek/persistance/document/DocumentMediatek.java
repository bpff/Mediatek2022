package com.example.projetmediatek.persistance.document;

import mediatek2022.Document;
import mediatek2022.Utilisateur;

import java.sql.*;

public class DocumentMediatek implements Document
{
    private String titre;
    private int idDocument;
    private boolean disponible;
    private int idEmprunteur;
    private String typeDoc;
    private String auteur;

    public DocumentMediatek(String titre, int idDocument, boolean disponible,String typeDoc, String auteur, int idEmprunteur ) {
        this.titre = titre;
        this.idDocument = idDocument;
        this.disponible = disponible;
        this.idEmprunteur = idEmprunteur;
        this.typeDoc = typeDoc;
        this.auteur = auteur;
    }

    private PreparedStatement statement(String sql) throws SQLException, ClassNotFoundException{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mediatek2022","root","root");
        return connection.prepareStatement(sql);
    }

    @Override
    public String toString() {
        return "DocumentMediatek{" +
                "titre='" + titre + '\'' +
                ", idDocument=" + idDocument +
                ", disponible=" + disponible +
                ", idEmprunteur=" + idEmprunteur +
                ", typeDoc='" + typeDoc + '\'' +
                ", auteur='" + auteur + '\'' +
                '}';
    }

    @Override
    public boolean disponible() {
        PreparedStatement dispo = null;
        boolean dispon = disponible;
        try{
            dispo = statement("Select * from document where idDocument = ?");
            dispo.setInt(1,this.idDocument);
            System.out.println(this.idDocument + " id du doc " + this.titre);
            ResultSet tt = dispo.executeQuery();
            if (!tt.next()) dispon = false;
            dispon = tt.getBoolean("disponible");
            System.out.println(dispon + titre);
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
        try{
            recupIdAbo = statement("Select idUtilisateur from utilisateur where login = ?");
            recupIdAbo.setString(1,u.name());
            ResultSet rr = recupIdAbo.executeQuery();
            int idAbo = rr.getInt("idUtilisateur");
            System.out.println(idAbo);
            updateEmprunt = statement("Update document set disponible = ?, idUtilsateurEmprunt = ? where idDocument = ?");
            updateEmprunt.setBoolean(1,false);
            updateEmprunt.setInt(2,idAbo);
            updateEmprunt.setInt(3,this.idDocument);
            int resultat = updateEmprunt.executeUpdate();
            System.out.println(resultat);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    @Override
    public void retour() {
        PreparedStatement req = null;
        try {
            req = statement("UPDATE mediatek2022.document SET disponible = true, idUtilsateurEmprunt = null WHERE" +
                    " idDocument = ? ");
            req.setInt(1, this.idDocument);
            int resultat = req.executeUpdate();
            System.out.println(resultat);
            req.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}

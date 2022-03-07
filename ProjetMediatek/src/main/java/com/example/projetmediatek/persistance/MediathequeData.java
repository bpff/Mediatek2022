package com.example.projetmediatek.persistance;

// classe mono-instance  dont l'unique instance est connue de la médiatheque
// via une auto-déclaration dans son bloc static

import com.example.projetmediatek.persistance.document.DocumentMediatek;
import com.example.projetmediatek.persistance.utilisateur.Abonne;
import com.example.projetmediatek.persistance.utilisateur.Bibliothecaire;
import mediatek2022.Document;
import mediatek2022.Mediatheque;
import mediatek2022.PersistentMediatheque;
import mediatek2022.Utilisateur;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MediathequeData implements PersistentMediatheque {
    // Jean-François Brette 01/01/2018
    private static Connection connection;
    static {
        Mediatheque.getInstance().setData(new MediathequeData());
    }

    private MediathequeData() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mediatek2022","root","root");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // renvoie la liste de tous les documents disponibles de la médiathèque
    @Override
    public List<Document> tousLesDocumentsDisponibles() {
        List<Document> listeDocumentsDispos = new ArrayList<>();
        int idDocument;
        String titreDocument;
        boolean disponible;
        String typeDocument;
        String auteur;
        int idUtilisateurEmprunt;
        Statement requeteStatique = null;
        try {
            requeteStatique = connection.createStatement();
            ResultSet tableResultat = requeteStatique.executeQuery
                    ("SELECT * FROM document where disponible = true");
            while (tableResultat.next()){
                idDocument=tableResultat.getInt("idDocument");
                titreDocument = tableResultat.getString("titreDocument");
                disponible=tableResultat.getBoolean("disponible");
                typeDocument = tableResultat.getString("typeDocument");
                auteur = tableResultat.getString("auteur");
                idUtilisateurEmprunt = tableResultat.getInt("idUtilsateurEmprunt");
                listeDocumentsDispos.add(new DocumentMediatek(titreDocument,idDocument,disponible,typeDocument,auteur,idUtilisateurEmprunt));
            }
            requeteStatique.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listeDocumentsDispos;
    }

    // va récupérer le User dans la BD et le renvoie
    // si pas trouvé, renvoie null
    @Override
    public Utilisateur getUser(String login, String password) {
        PreparedStatement req = null;
        try {
            req = connection.prepareStatement("select * from utilisateur where login = ? and password = ?");
            req.setString(1, login);
            req.setString(2, password);
            ResultSet result = req.executeQuery();
            if (!result.next()) return null;
            boolean bibliothecaire = result.getBoolean("bibliothecaire");
            System.out.println(bibliothecaire +" " + result.getString("login") );
            if(bibliothecaire){
                return new Bibliothecaire(
                        result.getInt("idUtilisateur"),
                        result.getString("login"),
                        result.getString("password"),
                        result.getInt("age"));
            }else{
                return new Abonne(
                        result.getInt("idUtilisateur"),
                        result.getString("login"),
                        result.getString("password"),
                        result.getInt("age"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // va récupérer le document de numéro numDocument dans la BD
    // et le renvoie
    // si pas trouvé, renvoie null
    @Override
    public Document getDocument(int numDocument) {
        PreparedStatement req = null;
        try {
            req = connection.prepareStatement("select * from document where idDocument = ?");
            req.setInt(1, numDocument);
            ResultSet result = req.executeQuery();
            if (!result.next()) return null;
            return new DocumentMediatek(
                    result.getString("titreDocument"),
                    result.getInt("idDocument"),
                                result.getBoolean("disponible"),
                                result.getString("typeDocument"),
                                result.getString("auteur"),
                                result.getInt("idUtilsateurEmprunt"));
        }

        catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
        }

    /**
     * ajoute un document dans la BD par le bibliothécaire
     * @param type le type du document
     * @param args les attributs du document
     */
    @Override
    public void ajoutDocument(int type, Object... args) {
        // args[0] -> le titre
        // args [1] --> l'auteur
        // etc... variable suivant le type de document
        String typeDoc="";
        switch (type){
            case 1 :
                typeDoc += "Livre";
                break;
            case 2:
                typeDoc += "DVD";
                break;
            case 3:
                typeDoc += "CD";
                break;
            default:
                typeDoc += "TypeInconnu";
        }
        Statement requeteStatique = null;
        try {
            requeteStatique = connection.createStatement();
            System.out.println("Insertion des données");
            String sql = "insert into document(titreDocument, disponible, typeDocument, auteur) " +
                    "values ('"+args[0]+"',"+args[1]+",'"+typeDoc+"','"+args[2]+"')";
            //args[0] --> titre, args[1]--> disponibilite,args[2]-->auteur
            int resultat = requeteStatique.executeUpdate(sql);
            System.out.println(resultat);
            String eee = resultat == 1 ? "réussie" : "pas réussie";
            System.out.println(eee);
            System.out.println(resultat + "Ajout du " + typeDoc + " " + args[0] + " avec pour auteur " + args[2] + " " + eee );
            requeteStatique.close();
        } catch (SQLException e) {
            args[3] = "Y'a un souci";
//            e.printStackTrace();
        }
    }


}

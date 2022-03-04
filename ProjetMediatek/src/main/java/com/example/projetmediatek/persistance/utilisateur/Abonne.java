package com.example.projetmediatek.persistance.utilisateur;

import mediatek2022.Utilisateur;

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
        Object[] toto = new Object[3];
        toto[0] = new Integer(age);
        return new Object[0];
    }
}

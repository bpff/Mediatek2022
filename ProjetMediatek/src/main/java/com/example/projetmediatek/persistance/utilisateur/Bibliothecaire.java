package com.example.projetmediatek.persistance.utilisateur;

import mediatek2022.Utilisateur;

public class Bibliothecaire implements Utilisateur {

    private final int idUtilisateur;
    private final String login;
    private final String password;
    private final int age;

    public Bibliothecaire(int idUtilisateur, String login, String password, int age) {
        this.idUtilisateur = idUtilisateur;
        this.login = login;
        this.password = password;
        this.age = age;
    }

    @Override
    public String name() {
        return this.login;
    }

    @Override
    public boolean isBibliothecaire() {
        return true;
    }

    @Override
    public String toString() {
        return "Bibliothécaire{" +
                "idUtilisateur=" + idUtilisateur +
                ", login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", age=" + age +
                ", bibliothécaire=" + isBibliothecaire() +
                '}';
    }

    @Override
    public Object[] data() {
        return new Object[0];
    }
}

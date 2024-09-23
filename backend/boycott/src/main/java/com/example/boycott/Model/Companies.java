package com.example.boycott.Model;

public class Companies {
     private String id ;
     private String nom;
     private byte[] image;

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public boolean isEstBoycotter() {
        return estBoycotter;
    }

    public void setEstBoycotter(boolean estBoycotter) {
        this.estBoycotter = estBoycotter;
    }
public Companies(){}
    private boolean  estBoycotter;
     public Companies(String nom ,boolean estBoycotter,byte[] image){

         this.nom=nom;
         this.estBoycotter=estBoycotter;
         this.image =image;     }


}

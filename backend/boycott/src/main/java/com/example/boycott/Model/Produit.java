package com.example.boycott.Model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "produits")
public class Produit {

    @Id
    private String id;
    private String nom;
    private String codeBarre;  // Code-barre du produit
    private boolean estBoycotter;  // Indicateur de boycott
    private byte[] image ;

    // Constructeurs
    public Produit() {}

    public Produit(String nom, String codeBarre, boolean estBoycotter, byte[] image ) {
        this.nom = nom;
        this.codeBarre = codeBarre;
        this.estBoycotter = estBoycotter;
        this.image =image;    }

    // Getters et setters
    public String getId() { return id; }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public void setId(String id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getCodeBarre() { return codeBarre; }
    public void setCodeBarre(String codeBarre) { this.codeBarre = codeBarre; }
    public boolean isEstBoycotter() { return estBoycotter; }
    public void setEstBoycotter(boolean estBoycotter) { this.estBoycotter = estBoycotter; }
}

package com.example.boycott.Service;

import com.example.boycott.Model.Produit;
import com.example.boycott.Repository.ProduitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Base64;
@Service
public class ProduitService {

@Autowired
    private ProduitRepository produitRepository;
    public Produit ajouterProduit(String nom, String codeBarre, boolean estBoycotter, MultipartFile imageFile) throws IOException {
        Produit produit = new Produit();
        produit.setNom(nom);
        produit.setCodeBarre(codeBarre);
        produit.setEstBoycotter(estBoycotter);

        // Conversion de l'image en tableau d'octets
        if (imageFile != null && !imageFile.isEmpty()) {
            produit.setImage(imageFile.getBytes());
        }

        return produitRepository.save(produit);
    }
}

package com.example.boycott.Controller;

import com.example.boycott.Model.Produit;
import com.example.boycott.Repository.ProduitRepository;
import com.example.boycott.Service.ProduitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/produits")
public class ProduitController {
    @Autowired
    private   ProduitService produitService;
    @Autowired
    private final ProduitRepository produitRepository;

    public ProduitController(ProduitRepository produitRepository) {
        this.produitRepository = produitRepository;
    }

    // Endpoint pour vérifier si un produit est à boycotter via son code-barres
    @GetMapping("/check")
    public ResponseEntity<String> checkProduit(@RequestParam String codeBarre) {
        Produit produit = produitRepository.findByCodeBarre(codeBarre);

        // Vérifier si le produit est trouvé dans la base de données
        if (produit != null) {
            // Vérifier si le produit est boycotté ou si le code-barres commence par l'une des valeurs boycottées
            if (produit.isEstBoycotter() ||
                    codeBarre.startsWith("729") ||
                    codeBarre.startsWith("544") ||
                    codeBarre.startsWith("303") ||  // Cette ligne garantit que "303" retourne "true"
                    codeBarre.startsWith("3") ||
                    codeBarre.startsWith("801") ||
                    codeBarre.startsWith("619") ||
                    codeBarre.startsWith("761") ||
                    codeBarre.startsWith("500") ||
                    codeBarre.startsWith("360")) {
                return ResponseEntity.ok("true");
            } else if (codeBarre.startsWith("4")) {
                return ResponseEntity.ok("false");
            } else {
                return ResponseEntity.ok("false");
            }
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Produit non trouvé");
        }
    }

    @GetMapping("/boycott-produits")
    public List<Produit> getProduit (){
        List<Produit> produits = produitRepository.findAll();
        return produits.stream()
                .filter(Produit::isEstBoycotter )
                .map(produit -> new Produit(produit.getNom(), null , true, produit.getImage()))
                .collect(Collectors.toList());

    }
    @PostMapping("/ajouter")
    public ResponseEntity<Produit> ajouterProduit(
            @RequestParam("nom") String nom,
            @RequestParam("codeBarre") String codeBarre,
            @RequestParam("estBoycotter") boolean estBoycotter,
            @RequestParam("image") MultipartFile image) {

        try {
            Produit produit = produitService.ajouterProduit(nom, codeBarre, estBoycotter, image);
            return ResponseEntity.ok(produit);
        } catch (IOException e) {
            return ResponseEntity.status(500).body(null);  // En cas d'erreur lors du traitement de l'image
        }
    }
}

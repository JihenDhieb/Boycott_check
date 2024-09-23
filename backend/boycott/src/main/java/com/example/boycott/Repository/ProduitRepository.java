package com.example.boycott.Repository;

import com.example.boycott.Model.Produit;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ProduitRepository extends MongoRepository<Produit, String> {
    Produit findByCodeBarre(String codeBarre);  // Recherche par code-barres
}

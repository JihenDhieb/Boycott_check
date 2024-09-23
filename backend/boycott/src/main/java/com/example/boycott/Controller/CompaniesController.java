package com.example.boycott.Controller;

import com.example.boycott.Model.Companies;
import com.example.boycott.Repository.CompaniesRepository;
import com.example.boycott.Service.CompaniesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/companies")
public class CompaniesController {
@Autowired
    private CompaniesService companiesService;
@Autowired
private CompaniesRepository companiesRepository;
@PostMapping
    public ResponseEntity<Companies> ajoutercompanies(
        @RequestParam("nom") String nom,
        @RequestParam("estBoycotter") Boolean estBoycotter,
        @RequestParam("image")MultipartFile image){
            try {
                Companies companies =companiesService.ajouterCompanies(nom,estBoycotter,image);
                return ResponseEntity.ok(companies);
            }catch(IOException e){
                return ResponseEntity.status(500).body(null);
            }
}
@GetMapping("/ListCompanies")
public List<Companies> ListCompanies(){
    List <Companies> companies = companiesRepository.findAll();
    return companies.stream()
            .filter(Companies::isEstBoycotter)
            .map(companie -> new Companies(companie.getNom(),true,companie.getImage()))
            .collect(Collectors.toList());


}

}

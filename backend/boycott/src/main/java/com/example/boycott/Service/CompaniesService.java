package com.example.boycott.Service;

import com.example.boycott.Model.Companies;
import com.example.boycott.Repository.CompaniesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class CompaniesService {
    @Autowired
    CompaniesRepository companiesRepository;
    public Companies ajouterCompanies(String nom ,boolean estBoycotter, MultipartFile imageFile) throws IOException{
        Companies companies =new Companies();
        companies.setNom(nom);
        companies.setEstBoycotter(estBoycotter);
        if(imageFile !=null && !imageFile.isEmpty()){
            companies.setImage(imageFile.getBytes());
        }
        return companiesRepository.save(companies);
    }

}

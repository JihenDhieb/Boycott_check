package com.example.boycott.Repository;

import com.example.boycott.Model.Companies;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CompaniesRepository extends MongoRepository<Companies,String> {
}

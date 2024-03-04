package com.example.datatablepractice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.datatablepractice.model.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

}

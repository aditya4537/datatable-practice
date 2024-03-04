package com.example.datatablepractice.controller;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.datatablepractice.model.Product;
import com.example.datatablepractice.repository.ProductRepository;


@RestController
public class ProductController {
	@Autowired
	private ProductRepository productRepository;

	@GetMapping("/")
	public ModelAndView index() {
		return new ModelAndView("main"); 
	}
	
	@GetMapping("/categoryWiseData")
	public ModelAndView category() {
//		for category wise sort data
		ModelAndView mv = new ModelAndView("index");
		List<Product> productList = productRepository.findAll();
		Map<String, List<Product>> groupedProducts = productList.stream()
				.collect(Collectors.groupingBy(Product::getCategory));
		mv.addObject("groupedProducts", groupedProducts);
		return mv;
	}
	
	@GetMapping("/products")
	public List<Product> getAllProducts(){
		return productRepository.findAll();
	}

	@GetMapping("/product/{id}")
	public Optional<Product> getAllProducts(@PathVariable long id){
		return productRepository.findById(id);
	}
	
	@PostMapping("/products/add")
    public ResponseEntity<Product> addProduct(@RequestBody Product product) {
        try {
            Product newProduct = productRepository.save(product);
            return new ResponseEntity<>(newProduct, HttpStatus.CREATED);
        } catch (Exception e) {
            // Handle any exception that might occur during product addition
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	
	@PutMapping("/editProduct/{id}")
    public ResponseEntity<Product> updateProduct(@PathVariable Long id, @RequestBody Product updatedProduct) {
        Optional<Product> productOptional = productRepository.findById(id);
        if (!productOptional.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        Product product = productOptional.get();
        product.setName(updatedProduct.getName());
        product.setCategory(updatedProduct.getCategory());
        product.setPrice(updatedProduct.getPrice());
        productRepository.save(product);
        return ResponseEntity.ok(product);
    }

    @DeleteMapping("/deleteProduct/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long id) {
        Optional<Product> productOptional = productRepository.findById(id);
        if (!productOptional.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        productRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
	
}

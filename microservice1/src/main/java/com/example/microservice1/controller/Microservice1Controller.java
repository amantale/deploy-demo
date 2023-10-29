package com.example.microservice1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Microservice1Controller {

    @GetMapping("/microservice1")
    public String displayHelloWorld(Model model){
        model.addAttribute("message", "Hello, World!");
        return "index";
    }

}
package com.example.microservice2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Microservice2Controller {

    @GetMapping("/microservice2")
    public String displayHelloWorld(Model model){
        model.addAttribute("message", "Hello, World!");
        return "index";
    }

}
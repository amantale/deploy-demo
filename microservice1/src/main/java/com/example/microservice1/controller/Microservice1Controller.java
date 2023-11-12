package com.example.microservice1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "")
public class Microservice1Controller {

    @GetMapping("/")
    public String displayHelloWorld(Model model){
        model.addAttribute("message", "Hello, World!");
        return "index";
    }

}
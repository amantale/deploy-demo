package com.example.microservice2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "")
public class Microservice2Controller {

    @GetMapping("/")
    public String displayHelloWorld(Model model){
        return "index";
    }

}
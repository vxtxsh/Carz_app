package com.example.cap06backend.cap06backend.Clubs;

import com.example.cap06backend.cap06backend.Clubs.DTO.ClubsDTO;
import com.example.cap06backend.cap06backend.Clubs.Entities.Clubs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/clubs")
public class ClubsController {

    private final ClubsService clubsService;

    @Autowired
    public ClubsController(ClubsService clubsService) {
        this.clubsService = clubsService;
    }

    @GetMapping("/all")
    public List<Clubs> getAllClubs(){
        return clubsService.getAllClubs();
    }

    @PostMapping("/create")
    public void setClubs(ClubsDTO clubsDTO){
        clubsService.setClubs(clubsDTO);
    }
}

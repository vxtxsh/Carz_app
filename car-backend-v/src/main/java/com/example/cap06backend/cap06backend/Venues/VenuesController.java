package com.example.cap06backend.cap06backend.Venues;

import com.example.cap06backend.cap06backend.Events.Entities.Events;
import com.example.cap06backend.cap06backend.Venues.DTO.VenuesDTO;
import com.example.cap06backend.cap06backend.Venues.Entities.Venues;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/venues")
public class VenuesController {

    private final VenuesService venuesService;

    @Autowired
    public VenuesController(VenuesService venuesService) {
        this.venuesService = venuesService;
    }

    @GetMapping("/all")
    public List<VenuesDTO> getAllVenues(){
        return venuesService.getAllVenues();
    }

    @PostMapping("/create")
    public void createVenue(@RequestBody VenuesDTO venuesDTO){
        venuesService.createVenue(venuesDTO);
    }
}

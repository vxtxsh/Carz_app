package com.example.cap06backend.cap06backend.Venues;

import com.example.cap06backend.cap06backend.Venues.DTO.VenuesDTO;
import com.example.cap06backend.cap06backend.Venues.Entities.Venues;
import com.example.cap06backend.cap06backend.Venues.Repositories.VenuesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class VenuesService {

    private final VenuesRepository venuesRepository;

    @Autowired
    public VenuesService(VenuesRepository venuesRepository) {
        this.venuesRepository = venuesRepository;
    }

    public List<VenuesDTO> getAllVenues(){
        List<Venues> venuesList = venuesRepository.findAll();
        return venuesList.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    public void createVenue(VenuesDTO venuesDTO) {
        Venues venue = new Venues();
        venue.setVenueName(venuesDTO.venueName());
        venuesRepository.save(venue);
    }

    private VenuesDTO convertToDto(Venues venue) {
        return new VenuesDTO(venue.getVenueId(), venue.getVenueName());
    }
}

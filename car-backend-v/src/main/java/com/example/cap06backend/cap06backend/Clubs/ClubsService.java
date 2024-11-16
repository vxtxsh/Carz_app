package com.example.cap06backend.cap06backend.Clubs;

import com.example.cap06backend.cap06backend.Clubs.DTO.ClubsDTO;
import com.example.cap06backend.cap06backend.Clubs.Entities.Clubs;
import com.example.cap06backend.cap06backend.Clubs.Repositories.ClubsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClubsService {

    private final ClubsRepository clubsRepository;

    @Autowired
    public ClubsService(ClubsRepository clubsRepository) {
        this.clubsRepository = clubsRepository;
    }

    public List<Clubs> getAllClubs(){
        return clubsRepository.findAll();
    }

    public void setClubs(ClubsDTO clubsDTO){

        String clubName = clubsDTO.clubName();

        if (clubsRepository.existsByClubName(clubName)) {
            throw new IllegalArgumentException("Club with name '" + clubName + "' already exists.");
        }

        Clubs newClub = new Clubs();
        newClub.setClubName(clubName);
        newClub.setClubDescription(clubsDTO.clubDescription());
        newClub.setClubContact(clubsDTO.clubContact());


        clubsRepository.save(newClub);

    }
}

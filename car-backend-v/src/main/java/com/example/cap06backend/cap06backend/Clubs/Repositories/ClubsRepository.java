package com.example.cap06backend.cap06backend.Clubs.Repositories;

import com.example.cap06backend.cap06backend.Clubs.Entities.Clubs;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClubsRepository extends JpaRepository<Clubs, Long> {

    boolean existsByClubName(String clubName);
}

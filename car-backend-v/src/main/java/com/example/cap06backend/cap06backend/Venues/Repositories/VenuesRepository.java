package com.example.cap06backend.cap06backend.Venues.Repositories;

import com.example.cap06backend.cap06backend.Types.Entities.Types;
import com.example.cap06backend.cap06backend.Venues.Entities.Venues;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface VenuesRepository extends JpaRepository<Venues, Long> {
    Optional<Venues> findByvenueName(String name);
}

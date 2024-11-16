package com.example.cap06backend.cap06backend.Events.Repositories;

import com.example.cap06backend.cap06backend.Events.Entities.Events;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventsRepository extends JpaRepository<Events, Long> {
    boolean existsByName(String eventName);
}

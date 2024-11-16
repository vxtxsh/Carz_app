package com.example.cap06backend.cap06backend.Types.Repositories;

import com.example.cap06backend.cap06backend.Types.Entities.Types;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TypesRepository extends JpaRepository<Types, Long> {
    Optional<Types> findByName(String name);
}

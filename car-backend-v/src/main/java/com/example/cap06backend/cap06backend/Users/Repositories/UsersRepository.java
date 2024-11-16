package com.example.cap06backend.cap06backend.Users.Repositories;

import com.example.cap06backend.cap06backend.Users.Entities.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsersRepository extends JpaRepository<Users, Long> {
    Users findByUserID(Long userId);
}

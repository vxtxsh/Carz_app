package com.example.cap06backend.cap06backend.Users.DTO;

public record UsersDto(
        Long userID,
        String username,
        String email,
        String password,
        String role

) {
}

package com.example.cap06backend.cap06backend.Users;

import com.example.cap06backend.cap06backend.Users.DTO.UsersDto;
import com.example.cap06backend.cap06backend.Users.Entities.Users;
import com.example.cap06backend.cap06backend.Users.Repositories.UsersRepository;
import org.apache.catalina.User;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsersService {

    private final UsersRepository usersRepository;

    public UsersService(UsersRepository usersRepository) {
        this.usersRepository = usersRepository;
    }

    public List<Users> getAllUsers(){
        return usersRepository.findAll();
    }


    public void SetUsers(List<UsersDto> usersDto) {
        for (UsersDto dto : usersDto) {
            Users user = usersRepository.findByUserID(dto.userID());
            if (user != null) {
                updateStudent(user, dto);
            } else {
                createNewStudent(dto);
            }
        }
    }

    private void updateStudent(Users users, UsersDto dto) {
        users.setEmail(dto.email());
        users.setRole(dto.role());
        users.setUsername(dto.username());
        users.setPassword(dto.password());
        usersRepository.save(users);
    }

    private void createNewStudent(UsersDto dto) {
        Users newUsers = new Users();
        newUsers.setEmail(dto.email());
        newUsers.setRole(dto.role());
        newUsers.setUsername(dto.username());
        newUsers.setPassword(dto.password());
        usersRepository.save(newUsers);
    }
}

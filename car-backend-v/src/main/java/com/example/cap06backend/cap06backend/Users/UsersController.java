package com.example.cap06backend.cap06backend.Users;

import com.example.cap06backend.cap06backend.Users.DTO.UsersDto;
import com.example.cap06backend.cap06backend.Users.Entities.Users;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UsersController {

    private final UsersService usersService;

    public UsersController(UsersService usersService) {
        this.usersService = usersService;
    }

    @GetMapping("/get/users")
    public List<Users> getAllUsers(){
        return usersService.getAllUsers();
    }

    @PostMapping("/set/users")
    public void SetUsers(@RequestBody List<UsersDto> usersDto){
        usersService.SetUsers(usersDto);
    }
}

package com.example.cap06backend.cap06backend.Types;

import com.example.cap06backend.cap06backend.Events.Entities.Events;
import com.example.cap06backend.cap06backend.Types.DTO.TypesDTO;
import com.example.cap06backend.cap06backend.Types.Entities.Types;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/types")
public class TypesController {

    private final TypesService typesService;

    @Autowired
    public TypesController(TypesService typesService) {
        this.typesService = typesService;
    }

    @GetMapping("/all")
    public List<TypesDTO> getAllTypes() {
        return typesService.getAllTypes();
    }

    @PostMapping("/create")
    public void createType(@RequestBody TypesDTO typesDTO) {
        typesService.createType(typesDTO);
    }
}

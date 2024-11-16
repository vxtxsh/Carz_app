package com.example.cap06backend.cap06backend.Types;

import com.example.cap06backend.cap06backend.Types.DTO.TypesDTO;
import com.example.cap06backend.cap06backend.Types.Entities.Types;
import com.example.cap06backend.cap06backend.Types.Repositories.TypesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TypesService {

    private final TypesRepository typesRepository;

    @Autowired
    public TypesService(TypesRepository typesRepository) {
        this.typesRepository = typesRepository;
    }

    public List<TypesDTO> getAllTypes() {
        List<Types> typesList = typesRepository.findAll();
        return typesList.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    public void createType(TypesDTO typesDTO) {
        Types type = new Types();
        type.setName(typesDTO.name());
        type.setEmail(typesDTO.email());
        type.setPhone(typesDTO.phone());
        typesRepository.save(type);
    }

    private TypesDTO convertToDto(Types type) {
        return new TypesDTO(type.getContactId(), type.getName(), type.getEmail(), type.getPhone());
    }
}

package com.example.cap06backend.cap06backend.Contacts;

import com.example.cap06backend.cap06backend.Contacts.DTO.ContactsDTO;
import com.example.cap06backend.cap06backend.Contacts.Entities.Contacts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/contacts")
public class ContactsController {

    private final ContactsService contactsService;

    @Autowired
    public ContactsController(ContactsService contactsService) {
        this.contactsService = contactsService;
    }

    @GetMapping("/all")
    public List<Contacts> getAllContacts(){
        return contactsService.getAllContacts();
    }

    @PostMapping("/create")
    public void setContacts(ContactsDTO contactsDTO){
        contactsService.setContacts(contactsDTO);
    }
}

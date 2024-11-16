package com.example.cap06backend.cap06backend.Contacts;

import com.example.cap06backend.cap06backend.Clubs.Entities.Clubs;
import com.example.cap06backend.cap06backend.Contacts.DTO.ContactsDTO;
import com.example.cap06backend.cap06backend.Contacts.Entities.Contacts;
import com.example.cap06backend.cap06backend.Contacts.Repositories.ContactsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContactsService {

    private final ContactsRepository contactsRepository;

    @Autowired
    public ContactsService(ContactsRepository contactsRepository) {
        this.contactsRepository = contactsRepository;
    }

    public List<Contacts> getAllContacts(){
        return contactsRepository.findAll();
    }

    public void setContacts(ContactsDTO contactsDTO){

        String contactName = contactsDTO.name();

        if (contactsRepository.existsByName(contactName)) {
            throw new IllegalArgumentException("Contact with name '" + contactName + "' already exists.");
        }

        Contacts newContact = new Contacts();
        newContact.setName(contactName);
        newContact.setEmail(contactsDTO.email());
        newContact.setPhone(contactsDTO.phone());

        contactsRepository.save(newContact);
    }
}

//package com.example.cap06backend.cap06backend.Events;
//
//import com.example.cap06backend.cap06backend.Events.DTO.EventsDTO;
//import com.example.cap06backend.cap06backend.Events.Entities.Events;
//import com.example.cap06backend.cap06backend.Clubs.Repositories.ClubsRepository;
//import com.example.cap06backend.cap06backend.Contacts.Repositories.ContactsRepository;
//import com.example.cap06backend.cap06backend.Events.Repositories.EventsRepository;
//import com.example.cap06backend.cap06backend.Types.Repositories.TypesRepository;
//import com.example.cap06backend.cap06backend.Venues.Repositories.VenuesRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//import java.util.List;
//
//@Service
//public class EventsService {
//    private final EventsRepository eventsRepository;
//    private final ClubsRepository clubsRepository;
//    private final ContactsRepository contactsRepository;
//    private final TypesRepository typesRepository;
//    private final VenuesRepository venuesRepository;
//
//    @Autowired
//    public EventsService(EventsRepository eventsRepository, ClubsRepository clubsRepository,
//                         ContactsRepository contactsRepository, TypesRepository typesRepository,
//                         VenuesRepository venuesRepository) {
//        this.eventsRepository = eventsRepository;
//        this.clubsRepository = clubsRepository;
//        this.contactsRepository = contactsRepository;
//        this.typesRepository = typesRepository;
//        this.venuesRepository = venuesRepository;
//    }
//
//    public List<Events> getAllEvents() {
//        return eventsRepository.findAll();
//    }
//
//    public void setEvents(EventsDTO eventsDTO) {
//        String eventName = eventsDTO.name();
//
//        if (eventsRepository.existsByName(eventName)) {
//            throw new IllegalArgumentException("Event '" + eventName + "' already exists.");
//        }
//
//        Events newEvent = new Events();
//        newEvent.setName(eventName);
//        newEvent.setDescription(eventsDTO.description());
//        newEvent.setDate(eventsDTO.date());
//        newEvent.setStartTime(eventsDTO.startTime());
//        newEvent.setEndTime(eventsDTO.endTime());
//        newEvent.setClub(clubsRepository.findById(eventsDTO.clubId()).orElseThrow(() -> new IllegalArgumentException("invalid club")));
//        newEvent.setContact(contactsRepository.findById(eventsDTO.contact().contactId()).orElseThrow(() -> new IllegalArgumentException("Invalid contact")));
//        newEvent.setVenue(venuesRepository.findByvenueName(eventsDTO.venue().venueName()).orElseThrow(() -> new IllegalArgumentException("invalid venue")));
//        newEvent.setType(typesRepository.findByName(eventsDTO.type().name()).orElseThrow(() -> new IllegalArgumentException("Invalid type")));
//
//        eventsRepository.save(newEvent);
//    }
//}
package com.example.cap06backend.cap06backend.Events;

import com.example.cap06backend.cap06backend.Events.DTO.EventsDTO;
import com.example.cap06backend.cap06backend.Events.Entities.Events;
import com.example.cap06backend.cap06backend.Clubs.Repositories.ClubsRepository;
import com.example.cap06backend.cap06backend.Contacts.Repositories.ContactsRepository;
import com.example.cap06backend.cap06backend.Events.Repositories.EventsRepository;
import com.example.cap06backend.cap06backend.Types.Repositories.TypesRepository;
import com.example.cap06backend.cap06backend.Venues.Repositories.VenuesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

@Service
public class EventsService {
    private final EventsRepository eventsRepository;
    private final ClubsRepository clubsRepository;
    private final ContactsRepository contactsRepository;
    private final TypesRepository typesRepository;
    private final VenuesRepository venuesRepository;

    @Autowired
    public EventsService(EventsRepository eventsRepository, ClubsRepository clubsRepository,
                         ContactsRepository contactsRepository, TypesRepository typesRepository,
                         VenuesRepository venuesRepository) {
        this.eventsRepository = eventsRepository;
        this.clubsRepository = clubsRepository;
        this.contactsRepository = contactsRepository;
        this.typesRepository = typesRepository;
        this.venuesRepository = venuesRepository;
    }

    public List<Events> getAllEvents() {
        return eventsRepository.findAll();
    }

    public void setEvents(EventsDTO eventDTO) {
        String eventName = eventDTO.name();

        if (eventsRepository.existsByName(eventName)) {
            throw new IllegalArgumentException("Event '" + eventName + "' already exists.");
        }

        Events newEvent = new Events();
        newEvent.setName(eventName);
        newEvent.setDescription(eventDTO.description());
        newEvent.setDate(eventDTO.date());
        newEvent.setStartTime(eventDTO.startTime());
        newEvent.setEndTime(eventDTO.endTime());
        newEvent.setClub(clubsRepository.findById(eventDTO.clubId()).orElseThrow(() -> new IllegalArgumentException("Invalid club")));
        newEvent.setContact(contactsRepository.findById(eventDTO.contact().contactId()).orElseThrow(() -> new IllegalArgumentException("Invalid contact")));
        newEvent.setVenue(venuesRepository.findByvenueName(eventDTO.venue().venueName()).orElseThrow(() -> new IllegalArgumentException("Invalid venue")));
        newEvent.setType(typesRepository.findByName(eventDTO.type().name()).orElseThrow(() -> new IllegalArgumentException("Invalid type")));

        if (eventDTO.image() != null && !eventDTO.image().isEmpty()) {
            byte[] imageBytes = Base64.getDecoder().decode(eventDTO.image());
            newEvent.setImage(imageBytes);
        }

        eventsRepository.save(newEvent);
    }
    public Optional<Events> getEventById(Long id) {
        return eventsRepository.findById(id);
    }
}



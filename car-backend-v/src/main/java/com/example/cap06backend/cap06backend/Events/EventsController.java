//package com.example.cap06backend.cap06backend.Events;
//
//import com.example.cap06backend.cap06backend.Events.DTO.EventsDTO;
//import com.example.cap06backend.cap06backend.Events.Entities.Events;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
//@RestController
//@RequestMapping("/events")
//public class EventsController {
//
//    private final EventsService eventsService;
//
//    @Autowired
//    public EventsController(EventsService eventsService) {
//        this.eventsService = eventsService;
//    }
//
//    @GetMapping("/all")
//    public List<Events> getAllEvents() {
//        return eventsService.getAllEvents();
//    }
//
//    @PostMapping("/create")
//    public ResponseEntity<String> setEvents(@RequestBody EventsDTO eventsDTO) {
//        try {
//            eventsService.setEvents(eventsDTO);
//            return new ResponseEntity<>("Event created successfully", HttpStatus.CREATED);
//        } catch (IllegalArgumentException e) {
//            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
//        }
//    }
//}
//package com.example.cap06backend.cap06backend.Events;
//
//import com.example.cap06backend.cap06backend.Events.DTO.EventsDTO;
//import com.example.cap06backend.cap06backend.Events.Entities.Events;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
//@RestController
//@RequestMapping("/events")
//public class EventsController {
//
//    private final EventsService eventsService;
//
//    @Autowired
//    public EventsController(EventsService eventsService) {
//        this.eventsService = eventsService;
//    }
//
//    @GetMapping
//    public ResponseEntity<List<Events>> getAllEvents() {
//        List<Events> events = eventsService.getAllEvents();
//        return ResponseEntity.ok(events);
//    }
//
//
//
//    @PostMapping("/create")
//    public ResponseEntity<String> createEvent(@RequestBody EventsDTO eventDTO) {
//        try {
//            eventsService.setEvents(eventDTO);
//            return new ResponseEntity<>("Event created successfully", HttpStatus.CREATED);
//        } catch (IllegalArgumentException e) {
//            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
//        } catch (Exception e) {
//            return new ResponseEntity<>("Error creating event: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//}
package com.example.cap06backend.cap06backend.Events;

import com.example.cap06backend.cap06backend.Events.DTO.EventsDTO;
import com.example.cap06backend.cap06backend.Events.Entities.Events;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/events")
public class EventsController {

    private final EventsService eventsService;

    @Autowired
    public EventsController(EventsService eventsService) {
        this.eventsService = eventsService;
    }

    @GetMapping("/")
    public ResponseEntity<List<Events>> getAllEvents() {
        List<Events> events = eventsService.getAllEvents();
        return ResponseEntity.ok(events);
    }

    @PostMapping("/create")
    public ResponseEntity<String> createEvent(@RequestBody EventsDTO eventDTO) {
        try {
            eventsService.setEvents(eventDTO);
            return new ResponseEntity<>("Event created successfully", HttpStatus.CREATED);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            return new ResponseEntity<>("Error creating event: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/{id}/image")
    public ResponseEntity<byte[]> getEventImage(@PathVariable Long id) {
        Optional<Events> eventOpt = eventsService.getEventById(id); // Modify service method if necessary
        if (eventOpt.isPresent()) {
            Events event = eventOpt.get();
            byte[] image = event.getImage(); // Assuming image is of type byte[]

            HttpHeaders headers = new HttpHeaders();
            headers.set(HttpHeaders.CONTENT_TYPE, MediaType.IMAGE_JPEG_VALUE); // Set MIME type accordingly

            return new ResponseEntity<>(image, headers, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}


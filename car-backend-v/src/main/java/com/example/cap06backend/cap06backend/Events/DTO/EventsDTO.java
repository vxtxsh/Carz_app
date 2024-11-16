//package com.example.cap06backend.cap06backend.Events.DTO;
//
//import com.example.cap06backend.cap06backend.Contacts.DTO.ContactsDTO;
//import com.example.cap06backend.cap06backend.Types.DTO.TypesDTO;
//import com.example.cap06backend.cap06backend.Venues.DTO.VenuesDTO;
//
//public record EventsDTO(
//
//        Long eventId,
//        String name,
//        String date,
//        String startTime,
//        String endTime,
//        VenuesDTO venue,
//        String description,
//        TypesDTO type,
//        ContactsDTO contact,
//        Long clubId
//
//) {
//}
package com.example.cap06backend.cap06backend.Events.DTO;

import com.example.cap06backend.cap06backend.Contacts.DTO.ContactsDTO;
import com.example.cap06backend.cap06backend.Types.DTO.TypesDTO;
import com.example.cap06backend.cap06backend.Venues.DTO.VenuesDTO;

public record EventsDTO(
        Long eventId,
        String name,
        String date,
        String startTime,
        String endTime,
        VenuesDTO venue,
        String description,
        TypesDTO type,
        ContactsDTO contact,
        Long clubId,
        String image // Change this to String to handle base64 data
) {
}


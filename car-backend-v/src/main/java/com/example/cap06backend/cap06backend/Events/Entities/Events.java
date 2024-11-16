//package com.example.cap06backend.cap06backend.Events.Entities;
//
//import com.example.cap06backend.cap06backend.Clubs.Entities.Clubs;
//import com.example.cap06backend.cap06backend.Contacts.Entities.Contacts;
//import com.example.cap06backend.cap06backend.Types.Entities.Types;
//import com.example.cap06backend.cap06backend.Venues.Entities.Venues;
//import jakarta.persistence.*;
//import lombok.Getter;
//import lombok.Setter;
//
//@Entity
//@Getter
//@Setter
//@Table(name = "events")
//public class Events {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "EventID")
//    private Long eventId;
//
//    @Column(name = "Name")
//    private String name;
//
//    @Column(name = "Date")
//    private String date;
//
//    @Column(name = "StartTime")
//    private String startTime;
//
//    @Column(name = "EndTime")
//    private String endTime;
//
//    @ManyToOne
//    @JoinColumn(name = "VenueID")
//    private Venues venue;
//
//    @Column(name = "Description")
//    private String description;
//
//    @ManyToOne
//    @JoinColumn(name = "TypeID")
//    private Types type;
//
//    @ManyToOne
//    @JoinColumn(name = "ContactID")
//    private Contacts contact;
//
//    @ManyToOne
//    @JoinColumn(name = "ClubID")
//    private Clubs club;
//}
package com.example.cap06backend.cap06backend.Events.Entities;

import com.example.cap06backend.cap06backend.Clubs.Entities.Clubs;
import com.example.cap06backend.cap06backend.Contacts.Entities.Contacts;
import com.example.cap06backend.cap06backend.Types.Entities.Types;
import com.example.cap06backend.cap06backend.Venues.Entities.Venues;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "events")
public class Events {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "EventID")
    private Long eventId;

    @Column(name = "Name")
    private String name;

    @Column(name = "Date")
    private String date;

    @Column(name = "StartTime")
    private String startTime;

    @Column(name = "EndTime")
    private String endTime;

    @ManyToOne
    @JoinColumn(name = "VenueID")
    private Venues venue;

    @Column(name = "Description")
    private String description;

    @ManyToOne
    @JoinColumn(name = "TypeID")
    private Types type;

    @ManyToOne
    @JoinColumn(name = "ContactID")
    private Contacts contact;

    @ManyToOne
    @JoinColumn(name = "ClubID")
    private Clubs club;

    @Lob
    @Column(name = "Image")
    private byte[] image;
}

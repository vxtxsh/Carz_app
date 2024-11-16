package com.example.cap06backend.cap06backend.Venues.Entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "venues")
public class Venues {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "VenueID")
    private Long venueId;

    @Column(name = "VenueName")
    private String venueName;
}

package com.example.cap06backend.cap06backend.Clubs.Entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "clubs")
public class Clubs {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ClubID")
    private Long clubId;

    @Column(name = "ClubName")
    private String clubName;

    @Column(name = "ClubDesc")
    private String clubDescription;

    @Column(name = "ClubContact")
    private String clubContact;

}

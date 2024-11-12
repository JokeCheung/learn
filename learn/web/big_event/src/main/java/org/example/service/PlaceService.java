package org.example.service;

import org.example.pojo.Place;

import java.util.List;

public interface PlaceService {
    List<Place> allPlace();
    List<Place> findPlace(String placeName);
}

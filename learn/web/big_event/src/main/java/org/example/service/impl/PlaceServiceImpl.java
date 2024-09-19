package org.example.service.impl;

import org.example.mapper.PlaceMapper;
import org.example.pojo.Place;
import org.example.service.PlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlaceServiceImpl implements PlaceService {

    @Autowired
    private PlaceMapper placeMapper;


    @Override
    public List<Place> getPlaceData() {
        return placeMapper.getPlaceData();
    }
}

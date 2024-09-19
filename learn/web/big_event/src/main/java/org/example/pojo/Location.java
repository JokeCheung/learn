package org.example.pojo;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

public @Data
class Location{
    @NotEmpty
    private String lng;
    @NotEmpty
    private String lat;

    public Location(String lng, String lat) {
        this.lng = lng;
        this.lat = lat;
    }


    public String getLng() {
        return lng;
    }

    public String getLat() {
        return lat;
    }
}
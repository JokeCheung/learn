package org.example.pojo;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;
import org.springframework.context.annotation.Primary;

@Data
public class Place{
    @NotEmpty
    private String adcode;
    @NotEmpty
    private String formatted_address;
    private Location location;

    @Override
    public String toString() {
        return "\n创建对象："+this.adcode+","+this.formatted_address+","+this.location.getLng()+","+this.location.getLat();
    }

    public String getAdcode() {
        return adcode;
    }

    public String getFormatted_address() {
        return formatted_address;
    }

    public Location getLocation() {
        return location;
    }

    public Place(String adcode, String formatted_address, String lng, String lat) {
        this.adcode = adcode;
        this.formatted_address = formatted_address;
        this.location = new Location(lng,lat);
    }
}



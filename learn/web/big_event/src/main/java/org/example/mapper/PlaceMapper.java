package org.example.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.pojo.Place;
import org.example.pojo.User;

import java.util.List;

@Mapper
public interface PlaceMapper {

    @Select("select * from place")
    List<Place> getPlaceData();
}





























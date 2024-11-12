package org.example.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.example.pojo.Place;

import java.util.List;

@Mapper
public interface PlaceMapper {

    @Select("select * from place")
    List<Place> allPlace();

    @Select("select * from place where formatted_address like CONCAT('%', #{placeName}, '%')")
    List<Place> findPlace(@Param("placeName") String placeName);
}





























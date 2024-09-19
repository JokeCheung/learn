package com.example.sunnyweather.ui.place

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentPagerAdapter
import androidx.recyclerview.widget.RecyclerView
import com.example.sunnyweather.R
import com.example.sunnyweather.databinding.PlaceItemBinding
import com.example.sunnyweather.logic.model.Place

class PlaceAdapter(private val fragment: Fragment, private val placeList: List<Place>) :
    RecyclerView.Adapter<PlaceAdapter.ViewHolder>() {
    private lateinit var binding: PlaceItemBinding
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PlaceAdapter.ViewHolder {
        //调用父容器上下文对象加载布局文件
//        val view = LayoutInflater.from(parent.context).inflate(R.layout.place_item, parent, false)
        //viewbinding加载布局文件
        binding = PlaceItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ViewHolder(binding.root)
    }

    override fun onBindViewHolder(holder: PlaceAdapter.ViewHolder, position: Int) {
        val place = placeList[position]
        holder.placeCode.text = place.adcode
        holder.placeAddress.text = place.formatted_address
    }

    override fun getItemCount(): Int = placeList.size

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
//        val placeName: TextView = view.findViewById(R.id.placeName)
//        val placeAddress: TextView = view.findViewById(R.id.placeAddress)
        val  placeCode:TextView = binding.placeCode
        val placeAddress: TextView = binding.placeAddress
    }
}
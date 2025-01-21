package com.example.sunnyweather.ui.place

import android.content.Intent
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentPagerAdapter
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.RecyclerView
import com.example.sunnyweather.R
import com.example.sunnyweather.activity.WeatherActivity
import com.example.sunnyweather.databinding.PlaceItemBinding
import com.example.sunnyweather.logic.model.Place
import com.example.sunnyweather.ui.weather.WeatherViewModel

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
//        holder.placeCode.text = place.adcode
        holder.placeAddress.text = place.formatted_address
        val position = holder.adapterPosition
        holder.itemView.setOnClickListener {
//            Toast.makeText(
//                fragment.context,
//                "点击 ${placeList[position].formatted_address}",
//                Toast.LENGTH_SHORT
//            ).show()
//            val intent = Intent(fragment.context, WeatherActivity::class.java).apply {
//                putExtra("adcode", place.adcode)
//                putExtra("place_name", place.formatted_address)
//                putExtra("location_lng", place.location.lng)
//                putExtra("location_lat", place.location.lat)
//            }
//            fragment.startActivity(intent)
            Log.e("测试","place.location.lng=${place.location.lng}")
            Log.e("测试","place.location.lat=${place.location.lat}")
            val activity=fragment.activity
            if(activity is WeatherActivity){
                activity.closeDrawers()
                activity.weatherViewModel.locationLng=place.location.lng
                activity.weatherViewModel.locationLat=place.location.lat
                activity.weatherViewModel.placeName=place.formatted_address
                activity.refreshWeather()
            }
        }
    }

    override fun getItemCount(): Int = placeList.size

    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        //        val placeName: TextView = view.findViewById(R.id.placeName)
//        val placeAddress: TextView = view.findViewById(R.id.placeAddress)
//        val placeCode: TextView = binding.placeCode
        val placeAddress: TextView = binding.placeAddress
    }
}
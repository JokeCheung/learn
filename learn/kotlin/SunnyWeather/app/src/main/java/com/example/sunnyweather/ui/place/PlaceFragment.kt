package com.example.sunnyweather.ui.place

import android.app.Activity
import android.media.Image
import android.os.Bundle
import android.text.Editable
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.ImageView
import android.widget.Toast
import androidx.core.widget.addTextChangedListener
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.sunnyweather.R
import com.example.sunnyweather.databinding.FragmentPlaceBinding
import com.example.sunnyweather.databinding.PlaceItemBinding
import com.example.sunnyweather.logic.model.Place

class PlaceFragment : Fragment() {

    lateinit var binding: FragmentPlaceBinding
    lateinit var rv: RecyclerView
    lateinit var searchPlaceEdit: EditText
    lateinit var bgImageView: ImageView

    val viewModel by lazy {
        ViewModelProviders.of(this).get(PlaceViewModel::class.java)
    }

    private lateinit var adapter: PlaceAdapter

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
//       val view=inflater.inflate(R.layout.fragment_place, container, false)
//        rv=view.findViewById(R.id.recyclerView)
//        searchPlaceEdit=view.findViewById(R.id.searchPlaceEdit)
//        bgImageView=view.findViewById(R.id.bgImageView)
//        return view
        binding = FragmentPlaceBinding.inflate(LayoutInflater.from(context), container, false)
        rv = binding.recyclerView
        bgImageView = binding.bgImageView
        searchPlaceEdit = binding.searchPlaceEdit
        return binding.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        val layoutManager = LinearLayoutManager(activity)
        rv.layoutManager = layoutManager
        adapter = PlaceAdapter(this, viewModel.placeList)
        rv.adapter = adapter
        searchPlaceEdit.addTextChangedListener { editable ->
            Log.e("PlaceFragment","onActivityCreated:addTextChangedListener")
            val content = editable.toString()
            if (content.isNotEmpty()) {
                viewModel.searchPlaces(content)
            } else {
                rv.visibility = View.GONE
                bgImageView.visibility = View.VISIBLE
                viewModel.placeList.clear()
                adapter.notifyDataSetChanged()
            }
        }

//        viewModel.initData()

        viewModel.placeLiveData.observe(this, Observer { result ->
            Log.e("PlaceFragment","viewModel:observe")
            val places = result.getOrNull()
            if (places != null) {
                Log.e("PlaceFragment","viewModel:places != null")
                rv.visibility = View.VISIBLE
                bgImageView.visibility = View.GONE
                viewModel.placeList.clear()
                viewModel.placeList.addAll(places)
                adapter.notifyDataSetChanged()
            } else {
                Log.e("PlaceFragment","viewModel:places == null")
                Toast.makeText(activity, "查询不到任何地点", Toast.LENGTH_SHORT).show()
                result.exceptionOrNull()?.printStackTrace()
            }
        })
    }
}
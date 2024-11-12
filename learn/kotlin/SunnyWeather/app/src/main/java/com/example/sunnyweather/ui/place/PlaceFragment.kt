package com.example.sunnyweather.ui.place

import android.app.Activity
import android.media.Image
import android.os.Bundle
import android.text.Editable
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
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
import learn.addressHead
import learn.entity.MyResponsePlace
import learn.retrofit.ResponseService
import learn.retrofit.TimeoutInterceptor
import okhttp3.OkHttpClient
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class PlaceFragment : Fragment() {

    lateinit var binding: FragmentPlaceBinding
    lateinit var rv: RecyclerView
    lateinit var searchPlaceEdit: EditText
    lateinit var bgImageView: ImageView
    lateinit var btn: Button

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
        btn=binding.refreshDataBtn
        adapter = PlaceAdapter(this, viewModel.placeList)
        val layoutManager = LinearLayoutManager(activity)
        rv.layoutManager = layoutManager
        rv.adapter = adapter
        return binding.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        btn.visibility=View.GONE
        btn.setOnClickListener({
            Log.e("PlaceFragment","btn 点击")
//            viewModel.searchPlaces("广州市")


//            val content = editable.toString()
//            if (content.isNotEmpty()) {
//                viewModel.searchPlaces(content)
//            } else {
//                rv.visibility = View.GONE
//                bgImageView.visibility = View.VISIBLE
//                viewModel.placeList.clear()
//                adapter.notifyDataSetChanged()
//            }
//            startRetrofitDeserializePlace()
//            adapter.notifyDataSetChanged()
//            viewModel.count++
//            searchPlaceEdit.text=Editable.Factory.getInstance().newEditable(viewModel.count.toString())
        })

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
        viewModel.placeLiveData.observe(this@PlaceFragment, Observer { result ->
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

    /**
     * Retrofit kotlin实现接口回调：内部实现了子线程，对响应体反序列化成指定JSON Model
     */
    private fun startRetrofitDeserializePlace() {
        val okHttpClient: OkHttpClient = OkHttpClient.Builder()
            .addInterceptor(TimeoutInterceptor())
            .build()

        val retrofit = Retrofit.Builder()
            .baseUrl(addressHead)
            .client(okHttpClient)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
        val responseService = retrofit.create(ResponseService::class.java)
        responseService.getPlaceData().enqueue(object : Callback<MyResponsePlace> {
            override fun onResponse(
                call: retrofit2.Call<MyResponsePlace>,
                retrofit2Response: Response<MyResponsePlace>
            ) {
                Log.e("PlaceFragment", "Retrofit请求成功")
                val response = retrofit2Response.body()
                val string = StringBuilder()
                val placeList=response?.data
//                val placeNameList= ArrayList<String>()
                if(placeList!=null){
                    Log.e("PlaceFragment", "placeList.size=${placeList.size}")
                    placeList.forEach { place ->
                        string.append("${place}\n")
//                        placeNameList.add(place.formatted_address)
                    }
//                    viewModel.searchPlaces("广州市")
//                    Log.e("PlaceFragment", "viewModel.placeList.size=${viewModel.placeList.value!!.size}")
                }
//                Log.e("SunnyWeatherActivity",string.toString())

            }

            override fun onFailure(call: retrofit2.Call<MyResponsePlace>, t: Throwable) {
                Log.e("PlaceFragment", "Retrofit请求失败")
            }
        })
    }


}
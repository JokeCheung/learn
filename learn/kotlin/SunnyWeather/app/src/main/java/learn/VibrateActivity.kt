package learn

import android.app.Service
import android.os.Bundle
import android.os.VibrationEffect
import android.os.Vibrator
import android.view.GestureDetector
import android.view.MotionEvent
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

import com.example.sunnyweather.R
import com.example.sunnyweather.databinding.ActivityVibarteBinding

class VibrateActivity : AppCompatActivity() {

    private lateinit var binding: ActivityVibarteBinding
    private var detector: GestureDetector? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityVibarteBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val vibrator = getSystemService(Service.VIBRATOR_SERVICE) as Vibrator

        detector = GestureDetector(this, object : GestureDetector.SimpleOnGestureListener() {
            override fun onLongPress(e: MotionEvent) {
                Toast.makeText(this@VibrateActivity, "手机震动", Toast.LENGTH_SHORT).show()
//                vibrator.vibrate(VibrationEffect.createOneShot(2000,255))
//                vibrator.vibrate(
//                    VibrationEffect.createWaveform(
//                        longArrayOf(400, 800, 1200),
//                        intArrayOf(80, 240, 80), 2
//                    )
//                )
               vibrator.vibrate(
                    VibrationEffect.createWaveform(
                        longArrayOf(100, 400, 1200), 1
                    )
                )
            }
        })


    }


    override fun onTouchEvent(event: MotionEvent): Boolean {
        return if (detector == null) {
            super.onTouchEvent(event)
        } else {
            detector!!.onTouchEvent(event)
        }

    }
}
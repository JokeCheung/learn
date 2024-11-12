package learn.db

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import android.widget.Toast

class MyDataBaseHelper(val context: Context, name: String, version: Int) :
    SQLiteOpenHelper(context, name, null, version) {

    private val createBook =
        "CREATE TABLE Book ( id INTEGER PRIMARY KEY AUTOINCREMENT,author TEXT,price REAL,pages INTEGER,name TEXT)"

    private val createCategory =
        "CREATE TABLE Category ( id INTEGER PRIMARY KEY AUTOINCREMENT,category_name TEXT,category_code INTEGER)"

    //数据库已存在不会重复调用
    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL(createBook)
        db.execSQL(createCategory)
        Toast.makeText(context,"Create succeeded",Toast.LENGTH_SHORT).show()
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {

        db.execSQL("drop table if exists Book")
        db.execSQL("drop table if exists Category")
        onCreate(db)
        Toast.makeText(context,"Upgrade succeeded",Toast.LENGTH_SHORT).show()

    }

}
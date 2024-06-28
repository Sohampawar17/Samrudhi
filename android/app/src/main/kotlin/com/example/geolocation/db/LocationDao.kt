package com.example.geolocation.db

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query

@Dao
interface LocationDao {
    @Insert
    fun insert(location: LocationEntity)

    @Query("SELECT * FROM LocationEntity")
    suspend fun getAll(): List<LocationEntity>

    @Query("DELETE FROM LocationEntity WHERE id = :id")
    suspend fun deleteById(id: Int)

    @Query("DELETE FROM LocationEntity")
    suspend fun deleteAll()

}
//
//  timeSlotVO.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 06/05/2022.
//

import Foundation

class TimeSlotVO {
    var cinemaName : String
    var cinemaID : Int
    var timeSlot : Timeslot
    var isSelect : Bool
    
    init(name: String,id: Int,slot: Timeslot, isSelected: Bool){
        self.cinemaName = name
        self.cinemaID = id
        self.timeSlot = slot
        self.isSelect = isSelected
    }
}

class cinemaType {
    var name : String
    var isSelected: Bool
    
    init(name : String, isSelected: Bool){
        self.name = name
        self.isSelected = isSelected
    }
}

var dummycinema = [
    cinemaType(name: "2D", isSelected: true),
    cinemaType(name: "3D", isSelected: false),
    cinemaType(name: "IMAX", isSelected: false)
    
]

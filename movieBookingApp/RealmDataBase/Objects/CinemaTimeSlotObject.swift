//
//  TimeSlotObject.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 02/06/2022.
//

import Foundation
import RealmSwift

class CinemaObject : Object {
    @Persisted(primaryKey: true) var uuid : String
    
    @Persisted var cinemaTimeSlot : List<CinemaTimeSlotObject>
    
    
}

class CinemaTimeSlotObject : Object {
    
    @Persisted var uuid : String
    @Persisted var cinemaID : Int
    @Persisted var cinema : String
    
    @Persisted var timeslots : List<TimeSlotObject>
    
    
    func toCinemaTimeSlot()->CinemaTimeSlot {
        var array : [Timeslot] = []
        timeslots.forEach { slot in
            array.append(slot.toTimeslot())
        }
        return CinemaTimeSlot(
            cinemaID: cinemaID,
            cinema: cinema,
            timeslots: array
        )
    }
    
}

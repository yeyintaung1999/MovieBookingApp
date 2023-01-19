//
//  TimeSlotObject .swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 02/06/2022.
//

import Foundation
import RealmSwift

class TimeSlotObject : Object {
    @Persisted var cinemaDayTimeSlotID : Int
    @Persisted var startTime : String
    
    func toTimeslot()->Timeslot {
        return Timeslot(cinemaDayTimeslotID: cinemaDayTimeSlotID, startTime: startTime)
    }
}

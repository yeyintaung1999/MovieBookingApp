// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cinemaTimeSlotResponse = try? newJSONDecoder().decode(CinemaTimeSlotResponse.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - CinemaTimeSlotResponse
struct CinemaTimeSlotResponse: Codable {
    let code: Int?
    let message: String?
    let data: [CinemaTimeSlot]?
}

// MARK: - Datum
struct CinemaTimeSlot: Codable {
    let cinemaID: Int?
    let cinema: String?
    let timeslots: [Timeslot]?

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case cinema, timeslots
    }
    
    func toCinemaTimeSlotObject(id:Int,date:String)->CinemaTimeSlotObject{
        let object = CinemaTimeSlotObject()
        object.uuid = "\(id),\(date)"
        object.cinemaID=cinemaID ?? 0
        object.cinema = cinema ?? ""
        var list : [TimeSlotObject] = []
        timeslots?.forEach({ slot in
            list.append(slot.toTimeSlotObject())
        })
        object.timeslots.append(objectsIn:list)
        return object
    }
}



//
//  SeatObject.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 03/06/2022.
//

import Foundation
import RealmSwift

class CinemaSeatObject : Object {
    
    @Persisted(primaryKey: true) var uuid : String
    
    @Persisted var seats : List<SeatObject>
}


class SeatObject : Object {
    @Persisted var uuid : String
    @Persisted var id : Int
    @Persisted var type : String
    @Persisted var seatName : String
    @Persisted var symbol : String
    @Persisted var price : Int
    
    func toSeat()->Seat {
        var enumvalue : TypeEnum = .text
        switch type {
        case "available":
            enumvalue = .available
        case "taken":
            enumvalue = .taken
        case "text":
            enumvalue = .text
        case "space":
            enumvalue = .space
        default :
            enumvalue = .space
        }
        return Seat(id: id,
                    type: enumvalue,
                    seatName: seatName,
                    symbol: symbol,
                    price: price
        )
    }
}

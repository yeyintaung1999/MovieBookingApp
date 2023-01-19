//
//  seatVO.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 24/02/2022.
//

import Foundation
//
//struct SeatVO {
//
//    var title : String
//    var type : String
//
//    func isSeatAvailable()->Bool {
//
//        return type == SEAT_TYPE_AVAILABLE
//
//    }
//
//    func isSeatTaken()->Bool {
//        return type == SEAT_TYPE_TAKEN
//    }
//
//    func isSeatEmpty()->Bool {
//        return type == SEAT_TYPE_EMPTY
//    }
//
//    func isSeatTitle()-> Bool{
//        return type == SEAT_TYPE_TITLE
//    }
//
//    func isSeatSelected()-> Bool {
//        return type == SEAT_TYPE_SELECTED
//    }
//
//}

public class SeatVO {
    var seat : Seat
    var isSelected : Bool
    
    init(seat: Seat, isSelected: Bool){
        self.seat = seat
        self.isSelected = isSelected
    }
}

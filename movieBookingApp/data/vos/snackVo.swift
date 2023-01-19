//
//  snackVo.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 20/05/2022.
//

import Foundation

struct SnackVO: Codable, Hashable {
    var id : Int
    var quantity : Int
    
    init(id:Int,quantity:Int){
        self.id = id
        self.quantity=quantity
    }
}

struct checkVO: Encodable {
    let cinema_day_timeslot_id : Int
    let row : String
    let seat_number : String
    let booking_date: String
    let total_price: Int
    let movie_id:Int
    let card_id:Int
    let cinema_id:Int
    let snacks:[SnackVO]
    
    enum CodingKeys: String, CodingKey {
        case cinema_day_timeslot_id
        case row
        case seat_number
        case booking_date
        case total_price
        case movie_id
        case card_id
        case cinema_id
        case snacks
    }
}



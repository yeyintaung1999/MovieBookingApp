//
//  CheckOutValuesObject.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 29/07/2022.
//

import Foundation

class DataObject{
    var profileData: LoginDataClass!
    var movieDetail: MovieDetail!
    var slot: Timeslot!
    var cinemaType: String!
    var cinemaName: String!
    var cinemaID: Int!
    var date: Date!
    var selectedSeat: [SeatVO]!
    var selectedSnack: [SnackVO]!
    var amount: Int!
    var cardID: Int!
    init(){
        
    }
}

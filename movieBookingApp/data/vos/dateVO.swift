//
//  dateVO.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 06/05/2022.
//

import Foundation

class dateVO {
    var date: Date = Date()
    
    
    var isSelected: Bool = false

    init(date: Date,isSelected:Bool){
        self.date = date
        
        
        self.isSelected = isSelected
    }
}

struct CinemaData{
    var weekday : Int
    var day: Int
    var month: Int
    var time : String
    var movieName : String
    var CinemaName : String
}

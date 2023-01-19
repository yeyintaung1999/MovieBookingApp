//
//  payMethodVO.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 21/05/2022.
//

import Foundation

class PayMethodVO {
    var method : PayMethod
    var isSelected : Bool
    
    init(method: PayMethod, isSelected: Bool){
        self.method = method
        self.isSelected = isSelected
    }
}

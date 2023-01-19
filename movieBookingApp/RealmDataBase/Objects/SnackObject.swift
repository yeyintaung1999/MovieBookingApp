//
//  SnackObject.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 03/06/2022.
//

import Foundation
import RealmSwift

class SnackObject : Object {
    @Persisted(primaryKey: true) var id : Int
    @Persisted var name : String
    @Persisted var datumDescription : String
    @Persisted var price : Int
    @Persisted var image : String
    
    
    func toSnack()->Snack {
        return Snack(
            id: id,
            name: name,
            datumDescription: datumDescription,
            price: price,
            image: image
        )
    }
}

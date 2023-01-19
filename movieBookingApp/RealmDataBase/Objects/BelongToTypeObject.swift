//
//  BelongToTypeObject.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 28/05/2022.
//

import Foundation
import RealmSwift

class BelongToTypeObject : Object{
    @Persisted(primaryKey: true) var name : String
    
    @Persisted(originProperty: "belongType") var movies : LinkingObjects<MovieObject>
}

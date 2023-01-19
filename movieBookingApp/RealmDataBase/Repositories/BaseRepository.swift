//
//  BaseRepository.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 28/05/2022.
//

import Foundation
import RealmSwift

class BaseRepository : NSObject{
    let realm = try! Realm()
    
    override init() {
        super.init()
        print(realm.configuration.fileURL?.absoluteString)
    }
}

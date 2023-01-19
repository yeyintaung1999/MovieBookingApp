//
//  ActorObject.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 28/05/2022.
//

import Foundation
import RealmSwift


class ActorObject : Object {
    @Persisted(primaryKey: true) var id : Int
    @Persisted var profilePath : String
    @Persisted var castID : Int
    
    @Persisted var movies : List<MovieObject>
    
    func toCast()->Cast{
        return Cast(
            adult: false,
            gender: 1,
            id: id,
            knownForDepartment: KnownForDepartment.acting,
            name: "",
            originalName: "",
            popularity: 0.0,
            profilePath: profilePath,
            castID: castID,
            character: "",
            creditID: "",
            order: 0
        
        )
    }
}

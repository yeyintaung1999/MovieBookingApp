//
//  movieObject.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 28/05/2022.
//

import Foundation
import RealmSwift


class MovieObject : Object {
    
    @Persisted(primaryKey: true) var id : Int
    @Persisted var originalTitle : String
    @Persisted var releaseDate : String
    @Persisted var genres : List<String>
    @Persisted var overview : String
    @Persisted var rating : Double
    @Persisted var runtime : Int
    @Persisted var posterPath : String
    
    @Persisted var belongType : List<BelongToTypeObject>
    @Persisted(originProperty: "movies") var belongCollection : LinkingObjects<BelongsToCollectionObject>
    @Persisted var casts : List<ActorObject>
    
    func toMovieStruct()->MovieStruct{
        var array : [String] = []
        array.append(contentsOf: genres)
        return MovieStruct(
            id: id,
            originalTitle: originalTitle,
            releaseDate: releaseDate,
            genres: array,
            posterPath: posterPath)
    }
    
    func toMovieDetail() -> MovieDetail {
        var array : [String] = []
        array.append(contentsOf: genres)
        var castArray : [Cast] = []
        casts.forEach { cast in
            castArray.append(cast.toCast())
        }
        return MovieDetail(
            id: id,
            originalTitle: originalTitle,
            releaseDate: releaseDate,
            genres: array,
            overview: overview,
            rating: rating,
            runtime: runtime,
            posterPath: posterPath,
            casts: castArray
        )
    }
    
}

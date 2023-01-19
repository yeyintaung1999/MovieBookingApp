//
//  ContentTypeRepository.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 28/05/2022.
//

import Foundation
import RealmSwift

protocol ContentTypeRepository{
    
    func save(name:String)->BelongToTypeObject
    func getMovies(type:MovieType, completion: @escaping ([MovieStruct])->Void)
    func getBelongsToType(type:MovieType)->BelongToTypeObject
    
}

class ContentTypeRepositoryImpl : BaseRepository, ContentTypeRepository{
    static let shared = ContentTypeRepositoryImpl()
    
    private var contentTypeMap = [String:BelongToTypeObject]()
    
    private override init(){
        
        super.init()
        
        initializeFunc()
        
    }
    
    func initializeFunc(){
        
        let data = realm.objects(BelongToTypeObject.self)
        
        if data.isEmpty {
            MovieType.allCases.forEach { type in
                self.save(name: type.rawValue)
            }
        } else {
            data.forEach{
                contentTypeMap[$0.name] = $0
            }
        }
        
    }
    
    func save(name:String)->BelongToTypeObject{
        let object = BelongToTypeObject()
        object.name = name
        do{
            try realm.write({
                realm.add(object, update: .modified)
            })
        } catch {
            print("Error while saving belongstotypeObject")
        }
        
        return object
    }
    
    
    
    func getMovies(type:MovieType, completion: @escaping ([MovieStruct])->Void){
        
        if let object = contentTypeMap[type.rawValue]{
            let result = object.movies.sorted( by: {(first,second)->Bool in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let firstDate = dateFormatter.date(from: first.releaseDate) ?? Date()
                let secondDate = dateFormatter.date(from: second.releaseDate) ?? Date()
                
                return firstDate.compare(secondDate) == .orderedDescending
            }).map {$0.toMovieStruct()}
            completion(result)
        } else {
            completion([MovieStruct]())
        }
        
    }
    
    
    
    func getBelongsToType(type:MovieType)->BelongToTypeObject{
        if let object = contentTypeMap[type.rawValue]{
            return object
        }
        
        return save(name: type.rawValue)
    }
    
    
    
}

enum MovieType : String, CaseIterable {
    case currentShowing = "Current Showing"
    case upcoming = "Upcoming"
}

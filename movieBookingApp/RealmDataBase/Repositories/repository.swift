//
//  repository.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 02/06/2022.
//

import Foundation
import RealmSwift

protocol RestRepository {
    
    func saveCinemaTimeSlots(id:Int,date:String,data:[CinemaTimeSlot])
    func getCinemaTimeSlots(id:Int,date:String,completion: @escaping ([CinemaTimeSlot])->Void)
    
}

class RestRepositoryImpl : BaseRepository, RestRepository {
   
    
    
    static let shared = RestRepositoryImpl()
    
    override init(){
        super.init()
    }
    
    func saveCinemaTimeSlots(id:Int,date:String,data:[CinemaTimeSlot]) {
        let objects = data.map { $0.toCinemaTimeSlotObject(id: id, date: date) }
        let object = CinemaObject()
        object.uuid = "\(id),\(date)"
        object.cinemaTimeSlot.append(objectsIn: objects)
        
        do{
            try realm.write({
                realm.add(object,update: .modified)
                //realm.add(objects)
                
            })
        }catch{
            
        }
    }
    
    func getCinemaTimeSlots(id: Int, date: String, completion: @escaping ([CinemaTimeSlot]) -> Void) {
        let object = realm.object(ofType: CinemaObject.self, forPrimaryKey: "\(id),\(date)")
        
        completion( (object?.cinemaTimeSlot.map { $0.toCinemaTimeSlot() })! )
    }
    
}

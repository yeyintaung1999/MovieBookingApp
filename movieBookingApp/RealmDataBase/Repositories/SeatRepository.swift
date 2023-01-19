//
//  SeatRepository.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 03/06/2022.
//

import Foundation

import RealmSwift
import RxSwift
import RxRealm

protocol SeatRepository {
    
    func saveSeat(id:Int,date:String,data:[[Seat]])
    func getSeat(id:Int,date:String,completion: @escaping ([Seat])->Void)
    
}

class SeatRepositoryImpl : BaseRepository, SeatRepository{
    
    static let shared = SeatRepositoryImpl()
    
    func saveSeat(id: Int, date: String, data: [[Seat]]) {
        let objects = data.map { $0.map { $0.toSeatObject(mid: id, date: date) } }
        var result : [SeatObject] = []
        objects.forEach { array in
            array.forEach { item in
                result.append(item)
            }
        }
        let object = CinemaSeatObject()
        object.uuid = "\(id),\(date)"
        object.seats.append(objectsIn: result)
        do{
            try realm.write({
                realm.add(object, update: .modified)
                //realm.add(result)
                
            })
        }catch{
            
        }
    }
    
    func getSeat(id: Int, date: String, completion: @escaping ([Seat]) -> Void) {
        let object = realm.object(ofType: CinemaSeatObject.self, forPrimaryKey: "\(id),\(date)")
        
        completion((object?.seats.map{ $0.toSeat() })!)
    }
    
    func rxGetSeat(id: Int, date: String)->Observable<[Seat]>{
        if let object = realm.object(ofType: CinemaSeatObject.self, forPrimaryKey: "\(id),\(date)"){
            return Observable.collection(from: object.seats)
                .flatMap { (list)->Observable<[Seat]> in
                    return Observable.create { observer in
                        observer.onNext(
                            list.map{ $0.toSeat()}
                        )
                        return Disposables.create()
                    }
                }
        } else {
            return Observable.empty()
        }
        
    }
    
    
}

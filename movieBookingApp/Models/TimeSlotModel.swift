//
//  TimeSlotModel.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 02/06/2022.
//

import Foundation
import CloudKit

protocol TimeSlotModel {
    func CinemaTimeSlot( id: Int,date: String, completion: @escaping (MTResult<[CinemaTimeSlot]>)->Void )
}

class TimeSlotModelImpl : BaseModel, TimeSlotModel {
    static let shared = TimeSlotModelImpl()
    override init(){}
    let restRepository = RestRepositoryImpl.shared
    func CinemaTimeSlot(id: Int, date: String, completion: @escaping (MTResult<[CinemaTimeSlot]>) -> Void) {
        
        networkAgent.CinemaTimeSlot(id: id, date: date) { result in
            switch result {
            case .success(let data):
                self.restRepository.saveCinemaTimeSlots(id: id, date: date, data: data.data!)
            case .failure(let error):
                print(error)
            }
            self.restRepository.getCinemaTimeSlots(id: id, date: date){
                completion(.success($0))
            }
        }
        
    }
    
    
}


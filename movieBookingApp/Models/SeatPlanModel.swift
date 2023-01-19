//
//  SeatPlanModel.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 03/06/2022.
//

import Foundation
import RealmSwift

protocol SeatModelProtocol {
    func CinemaSeat(id:Int, date:String, completion: @escaping (MTResult<[Seat]>)->Void)
}

class SeatModelImpl : BaseModel, SeatModelProtocol {
    let seatRepo = SeatRepositoryImpl.shared
    static let shared = SeatModelImpl()
    override init(){
        
    }
    
    func CinemaSeat(id:Int, date:String, completion: @escaping (MTResult<[Seat]>)->Void){
        networkAgent.CinemaSeat(id: id, date: date) { result in
            switch result {
            case .success(let data):
                self.seatRepo.saveSeat(id: id, date: date, data: data.data!)
            case .failure(let error):
                print(error)
            }
            self.seatRepo.getSeat(id: id, date: date){
                completion(.success($0))
            }
        }
    }
    
}

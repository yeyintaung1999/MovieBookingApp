//
//  RxSeatPlan.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 04/08/2022.
//

import Foundation
import RxSwift

protocol RxSeatPlanProtocol {
    func CinemaSeat(id:Int, date:String)->Observable<[Seat]>
}

class RxSeatPlanModel: RxSeatPlanProtocol {
    
    let networkAgent = NetworkAgent.shared
    
    let seatRepo = SeatRepositoryImpl.shared
    
    static let shared = RxSeatPlanModel()
    
    let disposeBag = DisposeBag()
    
    private init(){
        
    }
    
    func CinemaSeat(id: Int, date: String) -> Observable<[Seat]> {
        let remoteData = networkAgent.RxSeatPlan(id: id, date: date)
        return remoteData
            .flatMap({ (data) -> Observable<[Seat]> in
                self.seatRepo.saveSeat(id: id, date: date, data: data.data!)
                return self.seatRepo.rxGetSeat(id: id, date: date)
            })
    }
    
    
}

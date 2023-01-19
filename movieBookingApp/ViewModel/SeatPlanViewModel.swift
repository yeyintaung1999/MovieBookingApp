//
//  SeatPlanViewModel.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 04/08/2022.
//

import Foundation
import RxSwift

class SeatPlanViewModel {

    var seatModel : RxSeatPlanProtocol
    var seatArray: [SeatVO] = []
    var selectedSeats : [SeatVO] = []
    
    var disposeBag = DisposeBag()

    init(seatModel: RxSeatPlanProtocol = RxSeatPlanModel.shared){
        self.seatModel = seatModel
    }
    
    func getSeatToBindData(id: Int, date: String)->Observable<[SeatVO]> {
        let result = seatModel.CinemaSeat(id: id, date: date)
        return result
            .flatMap { (seats) -> Observable<[SeatVO]> in
                self.seatArray.removeAll()
                seats.forEach { seat in
                    self.seatArray.append( seat.toSeatVO() )
                }
                return Observable.create { observer in
                    observer.onNext(self.seatArray)
                    return Disposables.create()
                }
            }
    }

    func tapToSelectSeat(name: String, price: Int) {
        self.selectedSeats.removeAll()
        self.seatArray.forEach { seat in
            if seat.seat.seatName == name {
                if seat.isSelected {
                    seat.isSelected = false
                    
                } else {
                    seat.isSelected = true
                    
                }
            }
        }
        self.seatArray.forEach { seat in
            if seat.isSelected {
                self.selectedSeats.append(seat)
            }
        }
    }
    
    func handleDidSelectSeat()->Bool {
        if selectedSeats.count<1{
            return false
        } else {
            return true
        }
    }

}



//    func getSeatToBindData(id: Int, date: String)->Observable<[SeatVO]> {
//        return Observable.create { observer in
//            self.seatModel.CinemaSeat(id: id, date: date) { result in
//                switch result {
//                case .success(let data):
//                    self.seatArray.removeAll()
//                        var j=0
//                        while j<data.count {
//                            self.seatArray.append((data[j].toSeatVO()))
//                            j += 1
//                        }
//                    observer.onNext(self.seatArray)
//                case .failure(let message):
//                    print(message)
//                }
//            }
//            return Disposables.create()
//        }
//    }

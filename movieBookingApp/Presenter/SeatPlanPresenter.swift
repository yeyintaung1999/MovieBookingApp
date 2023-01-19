//
//  SeatPlanPresenter.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 05/08/2022.
//

import Foundation
import RxSwift

protocol SeatPlanViewProtocol {
    func bindDataToCollection(data: [Seat])
}

protocol SeatPlanPresenterProtocol {
    func initialFunc(id: Int, date: String)
}

class SeatPlanPresenter: SeatPlanPresenterProtocol {
    
    private var view: SeatPlanViewProtocol
    private var model: RxSeatPlanModel
    
    private var disposeBag = DisposeBag()
    
    init(viewController: SeatPlanViewProtocol,
         model: RxSeatPlanModel = RxSeatPlanModel.shared){
        self.view = viewController
        self.model = model
    }
    
    func initialFunc(id: Int, date: String) {
        
        RxSeatPlanModel.shared.CinemaSeat(id: id, date: date)
            .subscribe(onNext: { data in
                self.view.bindDataToCollection(data: data)
            })
            .disposed(by: disposeBag)
        
    }
    
    
}

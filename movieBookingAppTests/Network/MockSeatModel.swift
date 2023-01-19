//
//  MockSeatModel.swift
//  movieBookingAppTests
//
//  Created by Ye Yint Aung on 06/08/2022.
//

import Foundation
@testable
import movieBookingApp
import RxSwift

class MockSeatModel: RxSeatPlanProtocol {
    
    var seatResult: [Seat] = []
    
    init(){
        let mockDataFromJson: Data = try! Data(contentsOf: MockDataURL.validSeatPlanResponseURL)
        let responseData = try! JSONDecoder().decode(SeatResponse.self, from: mockDataFromJson)
        var result: [Seat] = []
        responseData.data?.forEach { array in
            array.forEach { item in
                result.append(item)
            }
        }
        seatResult = result
    }
    
    
    
    func CinemaSeat(id: Int, date: String) -> Observable<[Seat]> {
        return Observable.just(seatResult)
    }
    
    
}

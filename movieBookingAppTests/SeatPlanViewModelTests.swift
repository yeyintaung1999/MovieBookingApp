//
//  SeatPlanViewModelTests.swift
//  movieBookingAppTests
//
//  Created by Ye Yint Aung on 06/08/2022.
//

import XCTest
@testable
import movieBookingApp
import RxSwift

class SeatPlanViewModelTests: XCTestCase {
    
    var seatModel : RxSeatPlanProtocol!
    var viewModel: SeatPlanViewModel!
    var disposeBag : DisposeBag!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        seatModel = MockSeatModel()
        disposeBag = DisposeBag()
        viewModel = SeatPlanViewModel(seatModel: seatModel)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func test_viewModelInitState_withInitialization_returnCorrectState() throws {
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.seatArray.count, 0)
        XCTAssertEqual(viewModel.selectedSeats.count, 0)
    }
    
    func test_getCinemaData_appendDataToArray_arrayCountShouldIncrease() throws {
        viewModel.getSeatToBindData(id: 3, date: "2022-08-06")
            .subscribe(onNext: { array in
                XCTAssertGreaterThan(array.count, 0)
                XCTAssertEqual(array.count, 210)
            })
            .disposed(by: disposeBag)
    }
    
    func test_selectSeat_appendSeatToArray_increaseArrayCount() throws {
        let expectation = expectation(description: "wait for response")
        
        viewModel.getSeatToBindData(id: 3, date: "2022-08-06")
            .subscribe(onNext: { data in
                self.viewModel.tapToSelectSeat(name: "B-5", price: 2)
                XCTAssertTrue(self.viewModel.handleDidSelectSeat())
                XCTAssertEqual(self.viewModel.selectedSeats.count, 1)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 5)

    }
    
    func test_deselectSeat_removeFromArray_decreaseArrayCount() throws {
        let expectation = expectation(description: "Wait for Response")
        
        viewModel.getSeatToBindData(id: 3, date: "2022-08-06")
            .subscribe(onNext: { _ in
                self.viewModel.tapToSelectSeat(name: "B-5", price: 2)
                XCTAssertEqual(self.viewModel.selectedSeats.count, 1)
                self.viewModel.tapToSelectSeat(name: "B-5", price: 2)
                XCTAssertEqual(self.viewModel.selectedSeats.count, 0)
                XCTAssertFalse(self.viewModel.handleDidSelectSeat())
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 5)
    }

}

//
//  NetworkAgentTest.swift
//  movieBookingAppTests
//
//  Created by Ye Yint Aung on 05/08/2022.
//

import XCTest
@testable
import movieBookingApp
import Mocker
import Alamofire

class NetworkAgentTest: XCTestCase {
    
    var networkClient = NetworkAgent.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Alamofire.Session(configuration: configuration)
        networkClient.sessionManager = sessionManager

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_withValidQueries_and_validResult_shouldReturnsTrue() throws {
        let id = 3
        let date = "2022-08-06"
        let apiEndPoint = URL(string: "https://tmba.padc.com.mm/api/v1/seat-plan?&booking_date=\(date)&cinema_day_timeslot_id=\(id)")!
        
        let mockDataFormJson = try! Data(contentsOf: MockDataURL.validSeatPlanResponseURL)
        
        let expectation = expectation(description: "wait for response")
        
        let mock = Mock(
            url: apiEndPoint,
            dataType: .json,
            statusCode: 200,
            data: [.get: mockDataFormJson],
            additionalHeaders: ["Authorization":"Bearer \(defaults.string(forKey: "token") ?? "")"]
        )
        mock.register()
        
        networkClient.CinemaSeat(id: id, date: date) { response in
            switch response {
            case .success(let data):
                XCTAssertGreaterThan(data.data!.count , 1)
            case .failure(let message):
                print("\(message)")
                XCTFail("should not fail")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
    }
    
    func test_getSeat_withoutAuthenticationToken_returnSpecificError() throws {
        let id = 3
        let date = "2022-08-06"
        let apiEndPoint = URL(string: "https://tmba.padc.com.mm/api/v1/seat-plan?&booking_date=\(date)&cinema_day_timeslot_id=\(id)")!
        
        let mockDataFormJson = try! Data(contentsOf: MockDataURL.invalidAuthenticationResponseURL)
        
        let expectation = expectation(description: "wait for response")
        
        let mock = Mock(
            url: apiEndPoint,
            dataType: .json,
            statusCode: 401,
            data: [.get: mockDataFormJson],
            additionalHeaders: ["Authorization":"Bearer \(defaults.string(forKey: "token") ?? "")"]
        )
        mock.register()
        
        networkClient.CinemaSeat(id: id, date: date) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertGreaterThan(error.count, 0)
                XCTAssertEqual(error.description, "Response status code was unacceptable: 400.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

}

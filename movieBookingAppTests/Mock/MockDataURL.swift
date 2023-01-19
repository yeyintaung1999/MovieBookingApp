//
//  MockDataURL.swift
//  movieBookingAppTests
//
//  Created by Ye Yint Aung on 05/08/2022.
//

import Foundation
import Mocker

public final class MockDataURL {
    
    public static let validSeatPlanResponseURL: URL = Bundle(for: MockDataURL.self).url(forResource: "validResponse", withExtension: ".json")!
    
    public static let invalidAuthenticationResponseURL: URL = Bundle(for: MockDataURL.self).url(forResource: "invalidAuthentication", withExtension: ".json")!
    
}

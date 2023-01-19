//
//  EndPoints.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 13/04/2022.
//

import Foundation
import Alamofire

enum MTEndPoint : URLConvertible {
    case emailLogin
    case googleLogin
    case emailRegister
    case currentShowing
    case comingSoon
    case movieDetail(_ id:Int)
    case cinemaList
    case cinemaTimeSlot
    case snackList
    case seat
    case payMethod
    case createCard
    case checkout
    
    private var baseurl : String {
        return baseUrl
    }
    
    func asURL() throws -> URL {
        return url
    }
    
    
    var url : URL {
        let urlComponents = NSURLComponents(string: baseUrl.appending(apiPath))
        
        if(urlComponents?.queryItems == nil){
            urlComponents!.queryItems = []
        }
        //urlComponents!.queryItems!.append(contentsOf: [URLQueryItem(name: "api_key", value: apiKey)])
        return urlComponents!.url!
    }
    
    
    private var apiPath : String {
        switch self {
        case .emailLogin :
            return "/api/v1/email-login"
        case .googleLogin :
            return "/api/v1/google-login"
        case .emailRegister:
            return "/api/v1/register"
        case .currentShowing:
            return "/api/v1/movies?status=current&take=10"
        case .comingSoon:
            return "/api/v1/movies?status=comingsoon&take=10"
        case .movieDetail(let id):
            return "/api/v1/movies/\(id)"
        case .cinemaList:
            return "/api/v1/cinemas"
        case .cinemaTimeSlot:
            return "/api/v1/cinema-day-timeslots"
        case .snackList:
            return "/api/v1/snacks"
        case .seat:
            return "/api/v1/seat-plan"
        case .payMethod:
            return "/api/v1/payment-methods"
        case .createCard:
            return "/api/v1/card"
        case .checkout:
            return "/api/v1/checkout"
        }
    }
    
}


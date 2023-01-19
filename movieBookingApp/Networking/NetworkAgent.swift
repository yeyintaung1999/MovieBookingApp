//
//  NetworkAgent.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 13/04/2022.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

struct NetworkAgent {
    
    static let shared = NetworkAgent()
    
    private init() {
        
    }
    
    var sessionManager: Session = AF
    
    func loginWithEmail(email: String, password: String, completion: @escaping (MTResult<EmailLogin>)->Void){
        let parameter : [String:String] = [
            "email" : email,
            "password" : password
        ]
        AF.request(MTEndPoint.emailLogin.url, method: .post, parameters: parameter).responseDecodable(of: EmailLogin.self){ response in
            
            switch response.result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
        }
    }
    
    func registerWithEmail(name: String,email: String, phone: String, password: String,google: String, facebook: String, completion: @escaping (MTResult<EmailRegister>)->Void ){
        let parameter : [String:String] = [
            "name" : name,
            "email" : email,
            "phone" : phone,
            "password" : password,
            "google-access-token" : google,
            "facebook-access-token" : facebook
        ]
        AF.request(MTEndPoint.emailRegister.url, method: .post, parameters: parameter).responseDecodable(of: EmailRegister.self) { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
        }
    }
    
    func currentShowing( completion: @escaping (MTResult<CurrentShowingMovieList>)->Void) {
        
        AF.request(MTEndPoint.currentShowing.url).responseDecodable(of: CurrentShowingMovieList.self) { result in
            switch result.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(handleError(result, error, MTCommonResponseError.self)))
            }
            
        }
        
    }
    
    func comingSoon(completion: @escaping (MTResult<CurrentShowingMovieList>)->Void) {
        AF.request(MTEndPoint.comingSoon.url).responseDecodable(of: CurrentShowingMovieList.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
        }
    }
    
    func movieDetail(id : Int, completion: @escaping (MTResult<MovieDetailResponse>)->Void) {
        AF.request(MTEndPoint.movieDetail(id).url).responseDecodable(of: MovieDetailResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
                
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
        }
    }
    
    func CinemaList( completion: @escaping ( MTResult<CinemaListResponse> )->Void) {
        
        AF.request(MTEndPoint.cinemaList.url).responseDecodable(of: CinemaListResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
            
        }
        
    }
    
    func CinemaTimeSlot( id: Int,date: String, completion: @escaping (MTResult<CinemaTimeSlotResponse>)->Void ){
        let parameter : [String:String] = ["id":"\(id)",
                                           "date":"\(date)"]
        let header : HTTPHeaders = ["Authorization":"Bearer \(defaults.string(forKey: "token") ?? "")"]
        
        AF.request(MTEndPoint.cinemaTimeSlot.url, method: .get, parameters: parameter, headers: header).responseDecodable(of: CinemaTimeSlotResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
            
        }
    }
    
    func CinemaSeat(id:Int, date:String, completion: @escaping (MTResult<SeatResponse>)->Void){
        
        let parameter : [String:String] = [
            "cinema_day_timeslot_id":"\(id)",
            "booking_date":"\(date)"
        ]
        let header : HTTPHeaders = ["Authorization":"Bearer \(defaults.string(forKey: "token") ?? "")"]
        
        sessionManager.request(MTEndPoint.seat.url, method: .get, parameters: parameter, headers: header)
            .validate()
            .responseDecodable(of: SeatResponse.self){ response in
            
            switch response.result{
            case .success(let data):
                
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
            
        }
        
    }
    
    func SnackList( completion : @escaping (MTResult<SnackResponse>)->Void){
        let headers : HTTPHeaders = ["Authorization":"Bearer \(defaults.string(forKey: "token")!)"]
        
        AF.request(MTEndPoint.snackList.url, method: .get, headers: headers).responseDecodable( of : SnackResponse.self){ response in
            switch response.result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
        }
    }
    
    func PayMethod( completion : @escaping (MTResult<PayMethodsResponse>)->Void) {
        let headers : HTTPHeaders = ["Authorization":"Bearer \(defaults.string(forKey: "token")!)"]
        
        AF.request(MTEndPoint.payMethod.url, method: .get, headers: headers).responseDecodable(of: PayMethodsResponse.self){ response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
        }
    }
    
    func createCard( card_no: String, card_holder: String, exp_date: String, cvc: String, completion: @escaping (MTResult<CardCreateResponse>)->Void ){
        
        let parameter : [String:String] = [
            "card_number":card_no,
            "card_holder":card_holder,
            "expiration_date":exp_date,
            "cvc":cvc
        ]
        let header : HTTPHeaders = ["Authorization":"Bearer \(defaults.string(forKey: "token")!)"]
        
        AF.request(MTEndPoint.createCard.url, method: .post, parameters: parameter, encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: header).responseDecodable(of:CardCreateResponse.self){response in
            switch response.result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(handleError(response, error, MTCommonResponseError.self)))
            }
        }
        
    }
    
    func checkOut( timeslotID: Int, row: String, seatNumber: String, bookingDate: String, totalPrice: Int, movieID: Int, cardID: Int, cinemaID: Int, snacks: [SnackVO], completion: @escaping(MTResult<CheckoutResponse>)->Void){
        
        var request = try! URLRequest(url: MTEndPoint.checkout.url, method: .post)
        request.addValue("Bearer \(defaults.string(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONEncoder().encode(checkVO(cinema_day_timeslot_id: timeslotID, row: row, seat_number: seatNumber, booking_date: bookingDate, total_price: totalPrice, movie_id: movieID, card_id: cardID, cinema_id: cinemaID, snacks: snacks))
        AF.request(request)
            .responseDecodable(of: CheckoutResponse.self) { response in
                
                switch response.result{
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(handleError(response, error, MTCommonResponseError.self)))
                }
            }
    }
    
    func RxSeatPlan(id: Int,date: String)->Observable<SeatResponse>{
        let parameter : [String:String] = [
            "cinema_day_timeslot_id":"\(id)",
            "booking_date":"\(date)"
        ]
        let header : HTTPHeaders = ["Authorization":"Bearer \(defaults.string(forKey: "token") ?? "")"]
        
        return RxAlamofire.requestDecodable(.get, MTEndPoint.seat.url, parameters: parameter, encoding: URLEncoding.default, headers: header, interceptor: nil)
            .flatMap { response,data in
                return Observable.just(data)
            }
//                return Observable.create { observer in
//
//                    AF.request(MTEndPoint.seat.url, method: .get, parameters: parameter, headers: header).responseDecodable(of: SeatResponse.self){ response in
//                        switch response.result{
//                        case .success(let data):
//                            observer.onNext(data)
//                        case .failure(let error):
//                            observer.onError(error)
//                        }
//                    }
//                    return Disposables.create()
//                }
    }
    
    
    /*
     
     Network Error - Different Scenarios
     
     *JSON Serialization Error
     *Wrong URL Error
     *Incorrect Methods
     *Missing Credentials
     *4xx
     *5xx
     
     */
    
    //Customize Error Body
    
    private func handleError<T, E: MDBErrorModel>(
        _ response : DataResponse<T, AFError>,
        _ error : (AFError),
        _ errorBodyType : E.Type
    ) -> String {
        var respBody : String = ""
        var serverErrorMessage : String?
        var errorBody : E?
        
        if let respData = response.data {
            respBody = String(data: respData, encoding: .utf8) ?? "Empty Response Body"
            
            errorBody = try? JSONDecoder().decode(errorBodyType, from: respData)
            serverErrorMessage = errorBody?.message
        }
        
        let respCode : Int = response.response?.statusCode ?? 0
        
        let sourcePath : String = response.response?.url?.absoluteString ?? "no url"
        
        
        //1 - Essential Debug Info
        print(
        """
        ==========================
        URL
        ->\(sourcePath)
        
        Status
        ->\(respCode)
        
        Body
        -> \(respBody)
        
        Underlying Error
        -> \(String(describing: error.underlyingError))
        
        Error Description
        -> \(error.errorDescription!)
        
        =========================
        
        """
        
        )
        
        return serverErrorMessage ?? error.errorDescription ?? "undefined"
        
        
    }
    
}


protocol MDBErrorModel : Decodable {
    var message : String { get }
}

class MTCommonResponseError : MDBErrorModel {
    var message: String {
        return statusMessage
    }
    
    let statusMessage : String
    let statusCode : Int
    
    enum CodingKeys : String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}

enum MTResult<T> {
    case success(T)
    case failure(String)
}



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let payMethodsResponse = try? newJSONDecoder().decode(PayMethodsResponse.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - PayMethodsResponse
struct SeatResponse: Codable {
    let code: Int?
    let message: String?
    let data: [[Seat]]?
}

// MARK: - Datum
struct Seat: Codable {
    let id: Int?
    let type: TypeEnum?
    let seatName, symbol: String?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case id, type
        case seatName = "seat_name"
        case symbol, price
    }
    
    func toSeatObject(mid:Int,date:String)->SeatObject {
        let object = SeatObject()
        object.uuid = "\(mid),\(date)"
        object.id = id ?? 0
        object.type = type?.rawValue ?? ""
        object.seatName = seatName ?? ""
        object.symbol = symbol ?? ""
        object.price = price ?? 0
        return object
    }
    
    func toSeatVO()->SeatVO{
        return SeatVO(seat: Seat(id: id, type: type, seatName: seatName, symbol: symbol, price: price), isSelected: false)
    }
}

enum TypeEnum: String, Codable {
    case available = "available"
    case space = "space"
    case taken = "taken"
    case text = "text"
}

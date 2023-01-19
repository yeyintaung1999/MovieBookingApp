// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let checkoutResponse = try? newJSONDecoder().decode(CheckoutResponse.self, from: jsonData)

import Foundation

// MARK: - CheckoutResponse
struct CheckoutResponse: Codable {
    let code: Int?
    let message: String?
    let data: Checkout?
}

// MARK: - DataClass
struct Checkout: Codable {
    let id: Int?
    let bookingNo, bookingDate, row, seat: String?
    let totalSeat: Int?
    let total: String?
    let movieID, cinemaID: Int?
    let username: String?
    let timeslot: Timeslot?
    let snacks: [Snack]?
    let qrCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingNo = "booking_no"
        case bookingDate = "booking_date"
        case row, seat
        case totalSeat = "total_seat"
        case total
        case movieID = "movie_id"
        case cinemaID = "cinema_id"
        case username, timeslot, snacks
        case qrCode = "qr_code"
    }
}
//
// MARK: - Snack
//struct Snack: Codable {
//    let id: Int?
//    let name, snackDescription, image: String?
//    let price, unitPrice, quantity, totalPrice: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case snackDescription = "description"
//        case image, price
//        case unitPrice = "unit_price"
//        case quantity
//        case totalPrice = "total_price"
//    }
//}

// MARK: - Timeslot
//struct Timeslot: Codable {
//    let cinemaDayTimeslotID: Int?
//    let startTime: String?
//
//    enum CodingKeys: String, CodingKey {
//        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
//        case startTime = "start_time"
//    }
//}

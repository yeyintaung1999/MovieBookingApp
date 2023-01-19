// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cinemaListResponse = try? newJSONDecoder().decode(CinemaListResponse.self, from: jsonData)

import Foundation

// MARK: - CinemaListResponse
struct CinemaListResponse: Codable {
    let code: Int?
    let message: String?
    let data: [Cinema]?
}

// MARK: - Datum
struct Cinema: Codable {
    let id: Int?
    let name, phone, email, address: String?
}

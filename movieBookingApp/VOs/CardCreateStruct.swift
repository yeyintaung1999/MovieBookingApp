// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let createCardResponse = try? newJSONDecoder().decode(CreateCardResponse.self, from: jsonData)

import Foundation

// MARK: - CreateCardResponse
struct CardCreateResponse: Codable {
    let code: Int?
    let message: String?
    let data: [CardCreated]?
}

// MARK: - Datum
struct CardCreated: Codable {
    let id: Int?
    let cardHolder, cardNumber, expirationDate, cardType: String?

    enum CodingKeys: String, CodingKey {
        case id
        case cardHolder = "card_holder"
        case cardNumber = "card_number"
        case expirationDate = "expiration_date"
        case cardType = "card_type"
    }
}

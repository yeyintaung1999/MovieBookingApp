// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let combinedListResponse = try? newJSONDecoder().decode(CombinedListResponse.self, from: jsonData)

import Foundation

// MARK: - CombinedListResponse
public struct EmailLogin: Codable {
    let code: Int?
    let message: String?
    let data: LoginDataClass?
    let token: String?
}

// MARK: - DataClass
public struct LoginDataClass: Codable {
    let id: Int?
    let name, email, phone: String?
    let totalExpense: Int?
    let profileImage: String?
    let cards: [Card]?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
        case cards
    }
}

// MARK: - Card
struct Card: Codable {
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


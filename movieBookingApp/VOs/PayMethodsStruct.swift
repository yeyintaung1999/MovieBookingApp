// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let payMethodsResponse = try? newJSONDecoder().decode(PayMethodsResponse.self, from: jsonData)

import Foundation

// MARK: - PayMethodsResponse
struct PayMethodsResponse: Codable {
    let code: Int?
    let message: String?
    let data: [PayMethod]?
}

// MARK: - Datum
struct PayMethod: Codable {
    let id: Int?
    let name, datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
    }
}

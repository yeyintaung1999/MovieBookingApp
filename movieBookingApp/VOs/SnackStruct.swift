// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let snackResponse = try? newJSONDecoder().decode(SnackResponse.self, from: jsonData)

import Foundation

// MARK: - SnackResponse
struct SnackResponse: Codable {
    let code: Int?
    let message: String?
    let data: [Snack]?
}

// MARK: - Datum
struct Snack: Codable {
    let id: Int?
    let name, datumDescription: String?
    let price: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case price, image
    }
    
    func toSnackObject()->SnackObject{
        let object = SnackObject()
        object.id = id ?? 0
        object.name = name ?? ""
        object.datumDescription = datumDescription ?? ""
        object.price = price ?? 0
        object.image = image ?? ""
        return object
    }
}

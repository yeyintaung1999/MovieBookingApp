// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieDetailResponse = try? newJSONDecoder().decode(MovieDetailResponse.self, from: jsonData)

import Foundation

// MARK: - MovieDetailResponse
public struct MovieDetailResponse: Codable {
    let code: Int?
    let message: String?
    let data: MovieDetail?
}

// MARK: - DataClass
public struct MovieDetail: Codable {
    let id: Int?
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let overview: String?
    let rating: Double?
    let runtime: Int?
    let posterPath: String?
    let casts: [Cast]?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres, overview, rating, runtime
        case posterPath = "poster_path"
        case casts
    }
    
    func toMovieObject()->MovieObject {
        let object = MovieObject()
        object.id = id ?? 0
        object.originalTitle = originalTitle ?? ""
        object.releaseDate = releaseDate ?? ""
        object.genres.append(objectsIn: genres ?? [String]())
        object.overview = overview ?? ""
        object.rating = rating ?? 0.0
        object.runtime = runtime ?? 0
        object.posterPath = posterPath ?? ""
        var array : [ActorObject] = []
        casts?.forEach({ cast in
            array.append(cast.toActorObject())
        })
        object.casts.append(objectsIn: array)
        return object
    }
}



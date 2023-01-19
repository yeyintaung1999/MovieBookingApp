import Foundation

// MARK: - MovieDetailResponse
struct CurrentShowingMovieList: Codable {
    let code: Int?
    let message: String?
    let data: [MovieStruct]?
}

// MARK: - Datum
struct MovieStruct: Codable {
    let id: Int?
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres
        case posterPath = "poster_path"
    }
    
    func toMovieObject(type: BelongToTypeObject)->MovieObject{
        let object = MovieObject()
        object.id = id ?? 0
        object.originalTitle = originalTitle ?? ""
        object.releaseDate = releaseDate ?? ""
        object.posterPath = posterPath ?? ""
        object.genres.append(objectsIn: genres ?? [String]())
        object.belongType.append(type)
        return object
    }
}



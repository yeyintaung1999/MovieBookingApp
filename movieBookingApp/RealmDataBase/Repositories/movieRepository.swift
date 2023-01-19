//
//  movieRepository.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 28/05/2022.
//

import Foundation
import RealmSwift

protocol MovieRepository {
    func saveMovies(type: MovieType,data: [MovieStruct])
    func getMovies(completion: @escaping ([MovieStruct])->Void)
    func saveMovieDetail(data: MovieDetail)
    func getMovieDetail(id:Int, completion: @escaping (MovieDetail)->Void)
}

class MovieRepositoryImpl : BaseRepository, MovieRepository {
    
    let contentTypeRepository = ContentTypeRepositoryImpl.shared
    func saveMovies(type: MovieType,data: [MovieStruct]) {
        let result = data.map { movie in
            movie.toMovieObject(
                type: self.contentTypeRepository.getBelongsToType(type: type)
            )
        }
        
        
        do{
            try realm.write({
                realm.add( result , update: .modified)
            })
        } catch {
            print("Error while saving MovieList")
        }
    }
    
    func getMovies(completion: @escaping ([MovieStruct]) -> Void) {
        let objects = realm.objects(MovieObject.self)
        completion( objects.map { $0.toMovieStruct() } )

    }
    
    func saveMovieDetail(data: MovieDetail) {
        do {
            try realm.write({
                realm.add(data.toMovieObject(), update: .modified)
            })
        } catch {
            print("Error while saving MovieDetail")
        }
    }
    
    func getMovieDetail(id: Int, completion: @escaping (MovieDetail) -> Void) {
        let object = realm.object(ofType: MovieObject.self, forPrimaryKey: id)
        completion(object!.toMovieDetail())
        
    }
    
   
    
    static let shared = MovieRepositoryImpl()
    
    private override init(){}
}

//
//  MovieModel.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 27/05/2022.
//

import Foundation

protocol MovieModel {
    func currentShowing( completion: @escaping (MTResult<[MovieStruct]>)->Void)
    func comingSoon(completion: @escaping (MTResult<[MovieStruct]>)->Void)
    func movieDetail(id : Int, completion: @escaping (MTResult<MovieDetail>)->Void)
}

class MovieModelImpl: BaseModel, MovieModel{
    
    func movieDetail(id: Int, completion: @escaping (MTResult<MovieDetail>) -> Void) {
        networkAgent.movieDetail(id: id) { result in
            switch result {
            case .success(let data):
                self.movieRepository.saveMovieDetail(data: data.data!)
            case .failure(let error):
                print(error)
            }
            
            self.movieRepository.getMovieDetail(id: id){
                completion(.success($0))
            }
        }
    }
    

    
    static let shared = MovieModelImpl()
    let movieRepository = MovieRepositoryImpl.shared
    let contentTypeRepository = ContentTypeRepositoryImpl.shared
    
    func currentShowing(completion: @escaping (MTResult<[MovieStruct]>) -> Void) {
        networkAgent.currentShowing { result in
            switch result {
            case .success(let data):
                self.movieRepository.saveMovies(type: .currentShowing,data: data.data ?? [MovieStruct]())
            case .failure(let error):
                print(error)
            }
            
            self.contentTypeRepository.getMovies(type: .currentShowing){
                completion(.success($0))
            }
            
        }
    }
    
    func comingSoon(completion: @escaping (MTResult<[MovieStruct]>) -> Void) {
        networkAgent.comingSoon { result in
            switch result{
            case .success(let data):
                self.movieRepository.saveMovies(type: .upcoming, data: data.data ?? [MovieStruct]())
            case .failure(let error):
                print(error)
            }
            
            self.contentTypeRepository.getMovies(type: .upcoming){
                completion(.success($0))
            }
        }
        
    }
}

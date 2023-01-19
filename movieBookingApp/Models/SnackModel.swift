//
//  SnackModel.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 03/06/2022.
//

import Foundation
import RealmSwift

protocol SnackModel {
    func SnackList( completion : @escaping (MTResult<[Snack]>)->Void)
}

class SnackModelImpl : BaseModel, SnackModel {
    
    static let shared = SnackModelImpl()
    let snackRepo = SnackRepositoryImpl.shared
    
    override init(){
        
    }
    
    func SnackList(completion: @escaping (MTResult<[Snack]>) -> Void) {
        networkAgent.SnackList { result in
            switch result{
            case .success(let data):
                self.snackRepo.saveSnack(data: data.data!)
            case .failure(let error):
                print(error)
            }
            self.snackRepo.getSnack{
                completion(.success($0))
            }
        }
    }
    
    
}

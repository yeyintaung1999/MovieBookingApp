//
//  SnackRepository.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 03/06/2022.
//

import Foundation
import RealmSwift

protocol SnackRepository {
    
    func saveSnack(data:[Snack])
    func getSnack(completion: @escaping ([Snack])->Void)
    
}

class SnackRepositoryImpl : BaseRepository, SnackRepository {
    static let shared = SnackRepositoryImpl()
    
    override init(){
        
    }
    
    func saveSnack(data: [Snack]) {
        data.forEach { snack in
            do{
                try realm.write({
                    realm.add(snack.toSnackObject(), update: .modified)
                })
            } catch {
                print("Error while saving snacks")
            }
        }
    }
    
    func getSnack(completion: @escaping ([Snack]) -> Void) {
        let objects = realm.objects(SnackObject.self)
        completion( objects.map{ $0.toSnack() } )
    }
    
    
}

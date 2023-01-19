//
//  UserDefaults.swift
//  movieBookingApp
//
//  Created by Ye Yint Aung on 22/04/2022.
//

import Foundation

let defaults = UserDefaults.standard
func setDefaults(name:String, token: String, profilePath: String, password: String, email: String){
    defaults.set(name, forKey: "name")
    defaults.set(token, forKey: "token")
    defaults.set(profilePath, forKey: "profile")
    defaults.set(password, forKey: "password")
    defaults.set(email, forKey: "email")
}

//
//  Model.swift
//  MyProject
//
//  Created by Sergio Chocobar on 02/11/2021.
//

import Foundation

struct Account{
    let user:String
    let pass:String
}

struct Registered{
    let user1: Account = Account(user:"usuario@email.com", pass:"password")
    
    func isRegistered(account: Account) -> Bool{
        return account.user == user1.user && account.pass == user1.pass
    }
}


struct Track: Codable, Hashable {
    let title: String
    let artist: String?
    let album: String?
    let song_id: String
    let genre: String?
    let duration: Double?
}

var misTracks = [Track]()


enum PlayerStates {
    case play
    case pause
    case next
    case previous
}

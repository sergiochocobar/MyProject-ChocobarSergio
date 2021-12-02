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


//struct Track: Codable{
//    let title: String?
//    let artist: String?
//    let album: String?
//}
//
//let misTracks = [
//                Track(title:"Like A Rolling Stone", artist:"Bob Dylan", album:""),
//                Track(title:"Walk On The Wild Side", artist:"Lou Reed", album:""),
//                Track(title:"November Rain", artist:"Guns and Roses", album:""),
//                Track(title:"Another Brick in the Wall", artist:"Pink Floyd", album:""),
//                Track(title:"One", artist:"Metallica", album:"")
//                ]

struct Track: Codable {
    let title: String
    let artist: String?
    let album: String?
    let song_id: String
    let genre: String?
    let duration: Double?
}

var misTracks = [Track]()

//let misTracks = [Track(title:"Like A Rolling Stone", artist:"Bob Dylan", album:"", song_id:"1", genre:"Folk rock", duration:nil),
//                 Track(title:"Walk On The Wild Side", artist:"Lou Reed", album:"", song_id:"2", genre:nil, duration:nil),
//                 Track(title:"Hey Joe", artist:"The jimi Hendrix Experience", album:"", song_id:"3", genre:nil, duration:nil),
//                 Track(title:"Piece Of My Heart", artist:"Big Brother & The Holding Company", album:"", song_id:"4", genre:nil, duration:nil),
//                 Track(title:"Blowin' In The Wind", artist:"Bob Dylan", album:"", song_id:"5", genre:nil, duration:nil),
//                 Track(title:"I Heard It Through The Grapevine", artist:"Creedence Clearwater Revival", album:"", song_id:"6", genre:nil, duration:nil),
//                 Track(title:"Cry Baby", artist:"janis joplin", album:"", song_id:"7", genre:nil, duration:nil),
//                 Track(title:"Me And Bobby Mcgee", artist:"janis joplin", album:"", song_id:"8", genre:"Country", duration:nil)]


enum PlayerStates {
    case play
    case pause
    case next
    case previous
}

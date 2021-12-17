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
//    let duration: Double?
    
    enum CodingKeys : String, CodingKey{
        case artist
        case title = "name"
        case album
//        case duration
        case genre
        case song_id
    }
}

//enum Genero : String, Codable{
//    case Rock
//    case Pop
//    case Folclore
//    case Vacio = ""
//}

var misTracks = [Track]()


enum PlayerStates {
    case play
    case pause
    case next
    case previous
}

//Genera de forma global la playlist -- esto estaba en PlaylistDetailController
var tracks = Set<Track>()
var tracksArray = [Track]()
//---------------------------//
var loveTracks = [String]()

protocol opcMenu{
    func deleteSong(_ song:Track)
    func addToPlaylist(_ song:Track)
    func loveSong(_ song:Track)
}

enum buttonsActions: opcMenu{
    case delete
    case add
    case loveSong
}

extension buttonsActions {
    func deleteSong(_ song: Track) {
        let index: Int = misTracks.firstIndex(of: song)!
        misTracks.remove(at:index)
    }
    
    func addToPlaylist(_ song: Track) {
        tracks.insert(song)
        tracksArray = Array(tracks)
    }
    
    func loveSong(_ song: Track) {
        loveTracks.append(song.song_id)
        print(loveTracks)
    }
}

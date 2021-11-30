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


struct Track{
    let title: String?
    let artist: String?
    let album: String?
}

let misTracks = [
                Track(title:"Like A Rolling Stone", artist:"Bob Dylan", album:""),
                Track(title:"Walk On The Wild Side", artist:"Lou Reed", album:""),
                Track(title:"November Rain", artist:"Guns and Roses", album:""),
                Track(title:"Another Brick in the Wall", artist:"Pink Floyd", album:""),
                Track(title:"One", artist:"Metallica", album:"")
                ]

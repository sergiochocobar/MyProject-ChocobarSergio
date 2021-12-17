//
//  LoginViewModel.swift
//  MyProject
//
//  Created by Sergio Chocobar on 16/12/2021.
//

import Foundation
import UIKit
import CoreData

class LoginViewModel: ViewController {
    
    let model: Registered = Registered()
    
    var usernameOk = false
    var passwordOk = false
    
    var validUser = false
    var errorNumber = [Int()]
    
    func buttonLoginTouch(userTF: UITextField, passTF: UITextField) {
        errorNumber.removeAll()
        guard let user = userTF.text, let pass = passTF.text else { return }
        
        if(!user.isEmpty){
            if (user.isValidEmail()) {
                usernameOk = true
            }else{
                errorNumber.append(1) //el email es invalido
                return
            }
        }else{
            errorNumber.append(2) //campo de email vacio
            return
        }
        
        if(!pass.isEmpty){
            passwordOk = true
        }else{
            errorNumber.append(3) //campo de password vacio
            return
        }
        
        
        if(usernameOk && passwordOk){
            if(user == model.user1.user && pass == model.user1.pass){
                self.validUser = true
                savedData()
            }else{
                errorNumber.append(4) //El Usuario o la Contraseña son incorrectas
            }
        }
                
        /*--------------------------------*/
        /*--------------------------------*/
        
        func savedData() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let context = appDelegate.managedObjectContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracklist")
            request.returnsDistinctResults = false
            
            do {
                let result = try context!.fetch(request)
                misTracks = [Track]()
                
                for data in result as! [NSManagedObject] {
                    let title = data.value(forKey: "title") as? String
                    let artist = data.value(forKey: "artist") as? String
                    let album = data.value(forKey: "album") as? String
                    let genre = data.value(forKey: "genre") as? String
                    let songId = data.value(forKey: "song_id") as? String
                    
                    let track = Track(title: title ?? "",
                                      artist: artist ?? "",
                                      album: album ?? "",
                                      song_id: songId ?? "",
                                      genre: genre ?? "")
                    misTracks.append(track)
                    
                    
                }
                
            } catch {
                print("Fallo al obtener info de la BD, \(error), \(error.localizedDescription)")
            }
            
            downloadTracks()
            if false {// Poner la validacion de si hay o no internet
                //
            }
        }
        
        /*--------------------------------*/
        /*--------------------------------*/
        
        //----- Descargar listado de canciones ---------------
        func downloadTracks() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let context = appDelegate.managedObjectContext
            
            RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") {
                status, data in
                misTracks = [Track]()
                if let _data = data {
                    misTracks = _data
                    
                    // CORE DATA
                    if let _context = context {
                        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Tracklist")
                        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                        
                        do {
                            try  appDelegate.persistentStoreCoordinator?.execute(deleteRequest, with: _context)
                        } catch {
                            print(error)
                        }
                        
                        // Agregar contenido
                        for item in _data {
                            guard let tracksEntity = NSEntityDescription.insertNewObject(forEntityName: "Tracklist", into: _context) as? NSManagedObject else {
                                return
                            }
                            tracksEntity.setValue(item.artist, forKey: "artist")
                            tracksEntity.setValue(item.genre, forKey: "genre")
                            tracksEntity.setValue(item.album, forKey: "album")
                            tracksEntity.setValue(item.song_id, forKey: "song_id")
                            tracksEntity.setValue(item.title, forKey: "title")
                            do {
                                try _context.save()
                            } catch {
                                print("No se guardo la info \(error), \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }

    }
}

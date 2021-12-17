//
//  TracksTableViewController.swift
//  MyProject
//
//  Created by Sergio Chocobar on 05/11/2021.
//

import UIKit

class TracksTableViewController: UITableViewController, ButtonOnCellDelegate{
    

    func buttonTouchedOnCell(aCell: UITableViewCell) {
        let apvc = AudioPlayerViewController()
        if let index = tableView.indexPath(for: aCell) {
            tableView.selectRow(at: index, animated: false, scrollPosition: .none)
            let elTrack = misTracks[index.row]
            apvc.track = elTrack
            apvc.modalPresentationStyle = .fullScreen //lo hago fullscreen para que al momento de borrar una cancion se ejecute el willappear
//            apvc.delegate = self
        }
        self.present(apvc, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fondo Gradiente
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.tableView.bounds
        gradientLayer.colors = [ UIColor(red: 182.0/255.0, green: 87.0/255.0, blue: 148.0/255.0, alpha: 1.0).cgColor,UIColor(red: 86.0/255.0, green: 96.0/255.0, blue: 225.0/255.0, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundView = backgroundView
        
        //1- Le indicamos al TABLE VIEW de que tipo van a ser las celdas que va a mostrar
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "trackCell")
        self.tableView.rowHeight = 80;

        
        //NotificationCenter
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTable(_:)),
                                               name: NSNotification.Name("updateTable"),
                                               object: nil)
        
        let _ = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
            print("Timer fired!")
            NotificationCenter.default.post(name: NSNotification.Name("updateTable"), object: nil)
        }
    }
    
    @objc func updateTable(_ notification: Notification) {
        misTracks.append(Track(title: "Nueva cancion", artist: "Nuevo artista", album: "Nuevo album", song_id: "0", genre: "Genero"))
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        super.viewWillAppear(animated)
//        let callback:([Track]?, Error?) -> () = { canciones, error in
//            if error != nil{
//                print("Ha ocurrido un error")
//            }else{
//                misTracks = canciones ?? []
//                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//        let api = APIManager()
//        api.getMusic(completion: callback)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return misTracks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //2- lepedimos al table view una celda y lo casteamos al tipo de clase que se hizo en el paso uno
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackTableViewCell
        cell.backgroundColor = .clear
        // Usamos el INDEXPATH que es el INDICE PARA CADA FILA
        let elTrack = misTracks[indexPath.row]
        cell.track = elTrack
        cell.parent = self
        cell.titulo.text = elTrack.title
        cell.artista.text = elTrack.artist

        return cell
    }

}

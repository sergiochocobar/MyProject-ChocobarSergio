//
//  TracksTableViewController.swift
//  MyProject
//
//  Created by Sergio Chocobar on 05/11/2021.
//

import UIKit

class TracksTableViewController: UITableViewController, ButtonOnCellDelegate{
    
    func buttonTouchedOnCell(aCell: UITableViewCell) {
        view.endEditing(true)
        self.view.endEditing(true)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SongViewController") as? AudioPlayerViewController
        self.present(vc!, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //cambiar fondo de la tabla y letras blancas
//        self.tableView.backgroundColor = .black //esto es lo mismo que poner UIColor.black
        //1- Le indicamos al TABLE VIEW de que tipo van a ser las celdas que va a mostrar
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "trackCell")
        self.tableView.rowHeight = 80;
        
        //DownloadManager
        DownloadManager.shared.startDownload(url: URL(string: "https://speed.hetzner.de/100MB.bin")!)
        
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
        misTracks.append(Track(title: "Nueva cancion", artist: "Nuevo artista", album: "Nuevo album", song_id: "0", genre: "Genero", duration: 123))
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let callback:([Track]?, Error?) -> () = { canciones, error in
            if error != nil{
                print("Ha ocurrido un error")
            }else{
                misTracks = canciones ?? []
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        let api = APIManager()
        api.getMusic(completion: callback)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // return 5
        return misTracks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //2- lepedimos al table view una celda y lo casteamos al tipo de clase que se hizo en el paso uno
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackTableViewCell
        
//        cell.backgroundColor = .black
//        cell.textLabel?.textColor = .black
        
        // Usamos el INDEXPATH que es el INDICE PARA CADA FILA
        let elTrack = misTracks[indexPath.row]
        
//        cell.textLabel?.text = elTrack.title //Si lo dejo descomentado se superpone con los titulos de TRACK TABLE VIEW CELL
        
        //3- postwork 2 - Por ultimo asignamos la propiedad que especificamos en la sub clase
        cell.track = elTrack
        cell.parent = self //Esto nose porque no me sirve
        
        //Pasamos el titulo y el artista
        cell.titulo.text = elTrack.title
        cell.artista.text = elTrack.artist

        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

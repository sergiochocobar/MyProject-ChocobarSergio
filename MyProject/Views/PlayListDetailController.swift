//
//  PlayListDetailController.swift
//  MyProject
//
//  Created by Sergio Chocobar on 02/12/2021.
//

import UIKit

class PlayListDetailController: UIViewController, TracksPickerDelegate, UITableViewDataSource, UITableViewDelegate{

    let tv = UITableView()
    let textField = UITextField()
    let button1 = UIButton(type: .custom)
 
   
    func addTrack(track: Track) {
        tracks.insert(track)
        tracksArray = Array(tracks)
        tv.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath)
        let track = tracksArray[indexPath.row]
        cell.textLabel?.text = track.title
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setGradientBackground()
        
        self.view.addSubview(textField)
        textField.placeholder = "Playlist..."
        textField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5) 
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(button1)
        button1.setImage(UIImage(systemName: "plus.rectangle.fill.on.rectangle.fill"), for: .normal)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
        button1.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10).isActive = true
        button1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button1.addTarget(self, action:#selector(showView), for: .touchUpInside)
        
        self.view.addSubview(tv)
        tv.translatesAutoresizingMaskIntoConstraints=false
        tv.topAnchor.constraint(equalTo:textField.bottomAnchor, constant: 20).isActive = true
        tv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tv.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -20).isActive = true
        tv.backgroundColor = .lightGray.withAlphaComponent(0.5)
        tv.separatorColor = UIColor.systemBlue.withAlphaComponent(0.5)
        tv.separatorStyle = .singleLine
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "track")
        tv.dataSource = self
        tv.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tv.reloadData()
    }

    
    @objc func showView() {
       let trv = TracksPickerView (frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2))
       trv.delegate = self
       self.view.addSubview(trv)
   }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func tableview(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            //esto esta bien?
            let track = tracksArray.remove(at: indexPath.row)
            tracks.remove(track)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

}

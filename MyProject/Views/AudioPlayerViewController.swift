//
//  AudioPlayerViewController.swift
//  MyProject
//
//  Created by Sergio Chocobar on 05/11/2021.
//

import UIKit
import AudioPlayer

class AudioPlayerViewController: UIViewController {
    
    var isPlaying = true
    var song: AudioPlayer?
    
    var slider = UISlider() //Variable global del slider
    var timer = Timer()
    
    var track:Track?
    
    let menuBtn = UIButton(type: .custom)
    let dismissBtn = UIButton(type: .custom)
    let playBtn = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
//        view.backgroundColor = .white
        self.view.setGradientBackground()
        /*---------------------------------*/
        guard let url = Bundle.main.url(forResource: "cancion-ukelele", withExtension: ".mp3") else { return }
        
        do {
            song = try AudioPlayer(contentsOf: url)
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            
            song?.play()
        }
        catch {
            print ("ocurrió un error \(error.localizedDescription)")
        }
        /*---------------------------------*/
        super.viewDidLoad()
        
        //---------------Dismiss btn
        self.view.addSubview(dismissBtn)
        dismissBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
        dismissBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        dismissBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        dismissBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dismissBtn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        //---------------Menu Btn
        self.view.addSubview(menuBtn)
        menuBtn.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        menuBtn.translatesAutoresizingMaskIntoConstraints = false
        menuBtn.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
//        menu.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10).isActive = true
        menuBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        menuBtn.showsMenuAsPrimaryAction = true
        menuBtn.menu = setupBarButtonItem()
        
        //---------------Label
        let label1 = UILabel()
        label1.text = track?.title
        label1.font = UIFont.systemFont(ofSize:30, weight: .black)
        label1.textColor = .white
        label1.autoresizingMask = .flexibleWidth
        label1.translatesAutoresizingMaskIntoConstraints=true
        label1.frame=CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        label1.textAlignment = .center
        self.view.addSubview(label1)
        
        //---------------Boton Play
        let b1=UIButton(type: .system)
        b1.setTitle("Play", for: .normal)
        b1.autoresizingMask = .flexibleWidth
        b1.translatesAutoresizingMaskIntoConstraints=true
        b1.frame=CGRect(x: 20, y: 100, width: 100, height: 40)
        self.view.addSubview(b1)
        b1.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        
        //---------------Boton Stop
        let b2=UIButton(type: .system)
        b2.setTitle("Stop", for: .normal)
        b2.autoresizingMask = .flexibleWidth
        b2.translatesAutoresizingMaskIntoConstraints=true
        b2.frame=CGRect(x: 200, y: 100, width: 100, height: 40)
        self.view.addSubview(b2)
        b2.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        
        //---------------Slider Reproduccion
        slider.autoresizingMask = .flexibleWidth
        slider.translatesAutoresizingMaskIntoConstraints=true
        slider.frame=CGRect(x: 20, y:150, width: self.view.frame.width-40, height: 50)
        guard let duration = song?.duration else {return}
        slider.maximumValue = Float(duration)
        self.view.addSubview(slider)
        slider.addTarget(self, action: #selector(timeSound), for: .touchUpInside)
        
        
        //---------------Label Volumen
        let label2 = UILabel()
        label2.text = "Volumen"
        label2.font = UIFont.systemFont(ofSize: 16)
        label2.autoresizingMask = .flexibleWidth
        label2.translatesAutoresizingMaskIntoConstraints=true
        label2.frame=CGRect(x: 50, y: 200, width: self.view.frame.width, height: 50)
        label2.textAlignment = .left
        self.view.addSubview(label2)
        
        
        //---------------Slider Volumen
        let s2 = UISlider()
        s2.autoresizingMask = .flexibleWidth
        s2.translatesAutoresizingMaskIntoConstraints=true
        s2.frame=CGRect(x: 20, y:250, width: self.view.frame.width-200, height: 50)
        s2.value = 1.0
        self.view.addSubview(s2)
        s2.addTarget(self, action: #selector(slider2Touch(_ :)), for: .valueChanged)
        
        //---------------GIF AUDIO
        if let laURL = Bundle.main.url(forResource: "gif-audio", withExtension: ".gif") {
            let elGIF = UIImage.animatedImage(withAnimatedGIFURL: laURL)
            let imgContainer = UIImageView(image: elGIF)
            imgContainer.autoresizingMask = .flexibleWidth
            imgContainer.translatesAutoresizingMaskIntoConstraints=true
            imgContainer.frame=CGRect(x: 0, y: 350, width: self.view.frame.width, height: 150)
            self.view.addSubview(imgContainer)
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }

    @objc func playAction() {
        if (!isPlaying) {
            song?.play()
            isPlaying = true
        }
    }
    
    @objc func stopAction() {
        if (isPlaying) {
            song?.stop()
            isPlaying = false
        }
    }
    
    @objc func slider2Touch(_ sender:UISlider!) {
        song?.volume = sender.value
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if isPlaying {
            song?.stop()
            isPlaying = false
        } else {
            song?.play()
            isPlaying = true
        }
    }
    
    @objc func update(){
        guard let tiempo = song?.currentTime else {return}
        slider.value = Float(tiempo)
    }
    
    @objc func timeSound(sender: UISlider){
        if (isPlaying) {
            song?.stop()
            song?.currentTime = TimeInterval(sender.value)
            song?.play()
        }else{
            song?.stop()
            song?.currentTime = TimeInterval(sender.value)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        song?.stop()
    }
    
    
    func setupBarButtonItem() -> UIMenu{
        let menuItems = UIMenu(title: "", children: [
            UIAction(title: loveTracks.contains(self.track!.song_id) ? "Unlove" : "Love", image: UIImage(systemName: "heart")){
                action in
//                self.showSimpleAlert("Agregada a Favoritos")
                self.alertOK(title: "Love", message: "Agregado a Favoritos", action: "Listo")
                buttonsActions.loveSong.loveSong(self.track!)
            },
            UIAction(title: "Download", image: UIImage(systemName: "arrow.down.circle")){
                action in
                //DownloadManager
                DownloadManager.shared.startDownload(url: URL(string: "https://speed.hetzner.de/100MB.bin")!)
                self.alertOK(title: "Download", message: "Descargando canción", action: "Listo")
            },
            UIAction(title: "Add to Playlist", image: UIImage(systemName: "arrow.up.forward")){
                action in
                buttonsActions.add.addToPlaylist(self.track!)
                self.alertOK(title: "Add to Playlist", message: "Agregado a la Playlist", action: "Listo")
            },
            UIAction(title: "Delete from Library", image: UIImage(systemName: "trash"), attributes: .destructive){
                action in

                let refreshAlert = UIAlertController(title: "Delete from Library", message: "¿Estás seguro que desea eliminar esta canción?", preferredStyle: UIAlertController.Style.alert)

                refreshAlert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action: UIAlertAction!) in
                    //print("Handle Ok logic here")
                    buttonsActions.delete.deleteSong(self.track!)
                    self.dismiss(animated: true)
                }))

                refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
                      print("Handle Cancel Logic here")
                }))

                self.present(refreshAlert, animated: true, completion: nil)
            }
        ])
        return menuItems
    }
    
}

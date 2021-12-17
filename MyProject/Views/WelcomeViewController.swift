    import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var ImagenLogo: UIImageView!
    @IBOutlet weak var logOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setGradientBackground()
        ImagenLogo.image = UIImage(named: "ImagenLogo")
        welcomeLabel.textColor = .white
        logOut.buttonWhite()
        agregarGestosImagen()
    }
    
    
    func agregarGestosImagen(){
            self.ImagenLogo.isUserInteractionEnabled = true
            let gestureTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            self.ImagenLogo.addGestureRecognizer(gestureTap)

            let gesturePinch = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
            self.ImagenLogo.addGestureRecognizer(gesturePinch)

    }
    
    @IBAction func logout(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let compilado = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""

        //Pop up
        alertOK(title: "INFO", message: "Version: \(version)\n Compilado: \(compilado)\n \(appName)", action: "OK")
        
//        print("title: INFO, message: Version: \(version)\n Compilado: \(compilado)\n \(appName), action: OK")
        
    }

    @objc func didPinch(_ sender: UIPinchGestureRecognizer){
        if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)) {
                   guard scale.a > 1.0 else { return }
                   guard scale.d > 1.0 else { return }
                    sender.view?.transform = scale
                   sender.scale = 1.0
        }
    }
        
}



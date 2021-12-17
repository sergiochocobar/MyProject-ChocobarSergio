import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var signUpLabel: UILabel!
    //Coleccion de Textos
    @IBOutlet var textsLabel: [UILabel]!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var `continue`: UIButton!
    @IBOutlet weak var dismiss: UIButton!
    let model: Registered = Registered()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setGradientBackground()
        self.continue.buttonPink()
        self.dismiss.tintColor = .lightGray
        //Recorremos la coleccion para aplicarle color
        for text in textsLabel{
            text.textColor = .white
        }
    }
    
    @IBAction func `continue`(_ sender: Any) {
        guard let userNameField = email.text else{
            print("nil")
            return
        }
        
        
        if(!userNameField.isEmpty){
            self.email.textFieldRemoveRedBorderAnimation()
            if (userNameField.isValidEmail()) {
                if(userNameField == model.user1.user){
                    showSimpleAlert("El usuario ya existe")
                    self.email.textFieldErrorShakeAnimation()
                }else{
                    self.email.textFieldRemoveRedBorderAnimation()
                    //Rest Service Manager
                    RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") { status, data in
                       misTracks = [Track]()
                       if let _data = data {
                           misTracks = _data
                       }
                    }
                    goToMainViewController()
                }
            }else{
                showSimpleAlert("Escribe un email Válido")
                self.email.textFieldErrorShakeAnimation()
            }
        }else{
            showSimpleAlert("Completa correctamente el campo del Email")
            self.email.textFieldErrorShakeAnimation()
        }

    }
     
    @IBAction func dismissRegister(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    var counter: Int = 0
    var numbercolors: Int = 5
    
    @IBAction func facebookLogin(_ sender: Any) {
        let color: String = "Color"
        let colorname: String = color+"\(counter)"
        counter += 1
        signUpLabel.backgroundColor = UIColor(named: colorname)
        print(colorname)
        if counter > numbercolors {
          counter = 1
        }
    }
    
    func goToMainViewController() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? UITabBarController
        vc?.modalPresentationStyle = .fullScreen
        guard let vc = vc else{ return }
        present(vc, animated: true)
    }
    
    func checkUser(emailInput: String) -> Bool{
        let patron = #"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"#
        let regex = try! NSRegularExpression(pattern: patron, options: [])
        let matches = regex.matches(in:emailInput, options:[], range: NSRange(location:0, length: emailInput.count))
        return matches.count == 1 ? true : false
     }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


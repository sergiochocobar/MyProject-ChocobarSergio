import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var signUpLabel: UILabel!
    //Coleccion de Textos
    @IBOutlet var textsLabel: [UILabel]!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var facebookButton: UIButton!
    let model: Registered = Registered()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recorremos la coleccion para aplicarle color
        for text in textsLabel{
            text.textColor = UIColor(named: "TextColor")
        }
        
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
        

    }
    
    @IBAction func `continue`(_ sender: Any) {
        guard let userNameField = email.text else{
            print("nil")
            return
        }
        
        if(userNameField.isEmpty){
           print("Debe completar el campo del Email")
        }else if !checkUser(emailInput: userNameField){
            print("Ingrese un Email válido")
        }else if(model.user1.user == userNameField){
            print("El usuario ya existe")
        }else{
            print("Usuario Autenticado")
            goToMainViewController()
        }
    }
     
    @IBAction func dismissRegister(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    var counter: Int = 0
    var numbercolors: Int = 5
    
    @IBAction func facebookLogin(_ sender: Any) {
//        facebookButton.tintColor = UIColor(named: "FacebookButtonClick")
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
      let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
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


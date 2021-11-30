import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let model: Registered = Registered()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func `continue`(_ sender: UIButton) {
    
        guard let userNameField = userNameField.text, let passwordField = passwordField.text else{
            print("nil")
            return
        }
        
        if(userNameField.isEmpty){ //email no esta vacio
           print("Debe completar el campo del Email")
        }else if !checkUser(emailInput: userNameField){ //el email esta bien escrito
            print("Ingrese un Email válido")
        }else if(passwordField.isEmpty){ //password esta vacio
            print("Debe completar el campo de la Contraseña")
        }else if(model.user1.user != userNameField && model.user1.pass != passwordField ){ //el email y el password existen
            print("El usuario no existe")
        }else{
            print("Usuario Autenticado")
            goToMainViewController()
        }
    }
    
    func goToMainViewController() {
//      let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
        
        //Cambiar el identificador para que vaya al TAB BAR
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

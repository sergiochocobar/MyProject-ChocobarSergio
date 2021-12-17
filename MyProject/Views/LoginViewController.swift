import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var register: UIButton!

    // Variable de coneccion con viewModel
    var viewModel: LoginViewModel?
    
    //@IBAction func `continue`(_ sender: UIButton) {
    @IBAction func `continue`(_ sender: Any) {
        
        viewModel?.buttonLoginTouch(userTF: userNameField, passTF: passwordField)
        
        
        if viewModel!.errorNumber.contains(1) {
            showSimpleAlert("Escribe un Email Válido")
            userNameField.textFieldErrorShakeAnimation()
        }else{
            userNameField.textFieldRemoveRedBorderAnimation()
        }
        
        
        if viewModel!.errorNumber.contains(2) {
            showSimpleAlert("Debe completar el campo del Email")
            userNameField.textFieldErrorShakeAnimation()
        }else{
            userNameField.textFieldRemoveRedBorderAnimation()
        }
        
        
        if viewModel!.errorNumber.contains(3) {
            showSimpleAlert("Debe completar el campo del Password")
            passwordField.textFieldErrorShakeAnimation()
        }else{
            passwordField.textFieldRemoveRedBorderAnimation()
        }
        
        
        if viewModel!.errorNumber.contains(4) {
            showSimpleAlert("El Usuario o la Contraseña son incorrectas")
            userNameField.textFieldErrorShakeAnimation()
            passwordField.textFieldErrorShakeAnimation()
        }

        guard let valid = viewModel?.validUser else { return }
        if valid {
//            viewModel?.savedData()
            
//            RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") { status, data in
//               misTracks = [Track]()
//               if let _data = data {
//                   misTracks = _data
//               }
//            }
            goToMainViewController()
            viewModel?.validUser = false
        }
        
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setGradientBackground()
        login.buttonPink()
        register.buttonWhite()
        
        viewModel = LoginViewModel()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

        
    func goToMainViewController() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? UITabBarController
        vc?.modalPresentationStyle = .fullScreen

        guard let vc = vc else{ return }
        present(vc, animated: true)
    }

}

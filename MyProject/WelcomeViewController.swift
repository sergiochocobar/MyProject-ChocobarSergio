    import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var ImagenLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImagenLogo.image = UIImage(named: "ImagenLogo")
    }
    
    
    @IBAction func logout(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

}

import UIKit

class LogInTableViewController: UITableViewController {
    
    @IBOutlet weak var labelLogIn: UILabel!
    @IBOutlet weak var emailLogIn: UITextField!
    @IBOutlet weak var passwordLogIn: UITextField!
    @IBOutlet weak var passwordTextLogIn: UILabel!
    @IBOutlet weak var buttonLogIn: UIButton!
    @IBOutlet weak var buttonRegisterLogIn: UIButton!
    private let usersManager = UsersManager.shared
    
    @IBAction func buttonRegisterLogIn(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterTableViewController") as! RegisterTableViewController
        self.present(registerViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLogIn.text = nil
        emailLogIn.placeholder = "E-mail"
        
        passwordLogIn.text = nil
        passwordLogIn.placeholder = "Password"
        
        buttonLogIn.layer.cornerRadius = 10
        buttonLogIn.layer.borderWidth = 1
        buttonLogIn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        buttonLogIn.layer.masksToBounds = true
        
        buttonRegisterLogIn.layer.cornerRadius = 10
        buttonRegisterLogIn.layer.borderWidth = 1
        buttonRegisterLogIn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        buttonRegisterLogIn.layer.masksToBounds = true
    }
    
    @IBAction func buttonLogIn(_ sender: Any) {
        let username = emailLogIn.text ?? ""
        let userpassword = passwordLogIn.text ?? ""
        
        if (username.isEmpty && userpassword.isEmpty) {
            showError(with: ErrorType.emptyFields)
        }
        if (username.isEmpty) {
            showError(with: ErrorType.enterEmail)
        }
        if (userpassword.isEmpty) {
            showError(with: ErrorType.enterPassword)
        }
        
        guard let existedUserCred = usersManager.getUserCred(with: username) else {
            showError(with: ErrorType.wrongPerson)
            return
        }
        
        if (username == existedUserCred.email && userpassword != existedUserCred.password) {
            showError(with: ErrorType.wrongPassword)
        }
        if (username != existedUserCred.email && userpassword == existedUserCred.password) {
            showError(with: ErrorType.wrongEmail)
        }
    }
    
    func showError(with type: ErrorType) {
        let myAlert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}

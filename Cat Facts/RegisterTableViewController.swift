import UIKit
import Foundation

class RegisterTableViewController: UITableViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonLogInRegister: UIButton!
    private let usersManager = UsersManager.shared
    
    private enum LocalConstant {
        static let minPasswordLength = 5
    }
    
    @IBAction func buttonLogInRegister(_ sender: Any) {
        let logInViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogInTableViewController") as! LogInTableViewController
        
        self.present(logInViewController, animated: true)
    }
    
    @IBAction func buttonRegister(_ sender: AnyObject) {
        let userName = emailText.text ?? ""
        let userPassword = passwordText.text ?? ""
        let userConfirmPassword = confirmPasswordText.text ?? ""
        
        if (userName.isEmpty && userPassword.isEmpty && userConfirmPassword.isEmpty) {
            showError(with: ErrorType.emptyFields)
        }
        if (userPassword.isEmpty && userConfirmPassword.isEmpty) {
            showError(with: ErrorType.setPassword)
        }
        if (!userPassword.isEmpty && userPassword.count < LocalConstant.minPasswordLength) {
            showError(with: ErrorType.morePassword)
        }
        if (!userPassword.isEmpty && userConfirmPassword.isEmpty) {
            showError(with: ErrorType.confirmPassword)
        }
        if (userPassword != userConfirmPassword ) {
            showError(with: ErrorType.notMatch)
        }
        if isValidEmail(email: userName) == false {
            showError(with: ErrorType.errorEmail)
        }
        
        if let user = usersManager.getUserCred(with: userName) {
            showError(with: ErrorType.wrongName)
        } else {
            usersManager.saveUser(with: userName, password: userPassword)
        }
    }
    
    func showError(with type: ErrorType) {
        let myAlert = UIAlertController(title: "Error", message: type.rawValue, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        myAlert.addAction(okeyAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func isValidEmail(email:String?) -> Bool {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailText.text = nil
        emailText.placeholder = "E-mail"
        
        passwordText.text = nil
        passwordText.placeholder = "Password"
        
        confirmPasswordText.text = nil
        confirmPasswordText.placeholder = "Confirm password"
        
        buttonRegister.layer.cornerRadius = 10
        buttonRegister.layer.borderWidth = 1
        buttonRegister.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        buttonRegister.layer.masksToBounds = true
        
        buttonLogInRegister.layer.cornerRadius = 10
        buttonLogInRegister.layer.borderWidth = 1
        buttonLogInRegister.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        buttonLogInRegister.layer.masksToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

import Foundation

enum ErrorType: String {
    case emptyFields = "All fields are empty"
    case setPassword = "Please set password"
    case morePassword = "Password should has more then 5 symbols"
    case confirmPassword = "Please confirm password"
    case notMatch = "Password do not match. Please try again"
    case errorEmail = "Email entered is not correct. Example: name@gmail.com"
    case enterEmail = "Please enter e-mail"
    case enterPassword = "Please enter password"
    case notLogIn = "This user does not exist, go to registration"
    case wrongPassword = "Wrong password. Password should has more then 5 symbols"
    case wrongEmail = "Wrong e-mail"
    case loading = "Error loading cats"
    case wrongName = "The user with this email is already registered please select another name"
    case wrongPerson = "User with such email does not exist, please register"
}

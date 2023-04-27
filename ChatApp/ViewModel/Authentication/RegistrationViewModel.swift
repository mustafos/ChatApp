import Foundation

struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var username: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && username?.isEmpty == false
    }
}

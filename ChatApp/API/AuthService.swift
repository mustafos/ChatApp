import UIKit
import Firebase
import Foundation
import FirebaseStorage
import FirebaseFirestore

struct RegistrationCredentials {
    let email: String
    let password: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func loginUserIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData) { (meta, error) in
            if let error = error {
                print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Failed to create user with error \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let data = ["email": credentials.email,
                                "profileImagrUrl": profileImageUrl,
                                "uid": uid,
                                "username": credentials.username] as [String : Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
        }
    }
}

import Firebase
import Foundation
import FirebaseStorage
import FirebaseFirestore

struct Service {
    
    static func fetchUsers() {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                print(document.data())
            })
        }
    }
}

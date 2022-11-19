//
//  FirebaseErrorsManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import Foundation
import Firebase

final class FirebaseErrorsManager: FirebaseDatabaseInfo {
    static func saveError(_ errorText: String) {
        let reference = Database.database().reference().child("Errors").childByAutoId()
        let userUID = Auth.auth().currentUser?.uid ?? "-"
        let userEmail = Auth.auth().currentUser?.email ?? "-"
        reference.setValue(["error" : errorText,
                            "userEmail" : userEmail,
                            "sendBy" : userUID])
    }
}

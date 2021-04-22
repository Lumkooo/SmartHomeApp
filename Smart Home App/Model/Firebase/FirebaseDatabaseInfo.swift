//
//  FirebaseDatabaseInfo.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/22/21.
//

import Foundation
import Firebase

class FirebaseDatabaseInfo {
    // MARK: - Properties

    var userUID: String {
        guard let userUID = Auth.auth().currentUser?.uid else {
            // Не должно быть ситуации, когда Auth.auth().currentUser?.uid был бы nil,
            // потому что на все экраны, где это используется можно пройти только авторизовавшись
            // однако на всякий случай:
            assertionFailure("Can't take userUID")
            return ""
        }
        return userUID
    }
    let databaseRef = Database.database().reference()
    lazy var devicesRef = self.databaseRef.child(self.userUID).child("devices")
}

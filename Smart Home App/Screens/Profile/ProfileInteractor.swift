//
//  ProfileInteractor.swift
//  FocusStartProject
//
//  Created by Андрей Шамин on 12/8/20.
//

import Foundation

protocol IProfileInteractor {
    func prepareView()
    func logout()
}

protocol IProfileInteractorOuter: class {
    func setupViewForAuthorizedUser(userEmail: String)
    func setupViewForUnauthorizedUser()
    func alertOccured(stringError: String)
}

final class ProfileInteractor {
    
    // MARK: - Properties
    
    private var firebaseAuthManager = FirebaseAuthManager()
//    private var firebaseDatabaseManager = FirebaseDatabaseManager()
    weak var presenter: IProfileInteractorOuter?
    private let profileDelegate: IProfileDelegate

    // MARK: - Init

    init(profileDelegate: IProfileDelegate) {
        self.profileDelegate = profileDelegate
    }
}

// MARK: - IProfileInteractor

extension ProfileInteractor: IProfileInteractor {
    func prepareView() {
        self.setupView()
    }
    
    func logout() {
        firebaseAuthManager.logout {
            self.setupView()
//            NotificationCenter.default.post(
//                name: NSNotification.Name(
//                    rawValue: AppConstants.NotificationNames.refreshLikedPlaces),
//                object: nil)
        } errorCompletion: { (error) in
            self.presenter?.alertOccured(stringError: error.localizedDescription)
        }
    }
}

private extension ProfileInteractor {
    func setupView() {
        if firebaseAuthManager.isSignedIn {
            // Показываем view-профиль пользователя
            let userEmail = self.getUserEmail()
            self.presenter?.setupViewForAuthorizedUser(userEmail: userEmail)
            self.profileDelegate.userSignIn()
        } else {
            // Показываем view с кнопками регистрации/авторизации
            self.presenter?.setupViewForUnauthorizedUser()
            self.profileDelegate.userSignOut()
        }
    }
    
    func getUserEmail() -> String {
        return firebaseAuthManager.userEmail
    }
}


//
//  SendErrorInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import Foundation

protocol ISendErrorInteractor {
    func sendError(_ errorText: String)
}

protocol ISendErrorInteractorOuter: AnyObject {
    func goToThanksAlert()
}

final class SendErrorInteractor {
    
    // MARK: - Properties

    weak var presenter: ISendErrorInteractorOuter?
}

// MARK: - ISendErrorInteractor

extension SendErrorInteractor: ISendErrorInteractor {
    func sendError(_ errorText: String) {
        FirebaseErrorsManager.saveError(errorText)
        self.presenter?.goToThanksAlert()
    }
}

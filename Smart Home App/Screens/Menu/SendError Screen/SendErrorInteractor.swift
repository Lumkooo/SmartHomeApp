//
//  SendErrorInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import Foundation

protocol ISendErrorInteractor {

}

protocol ISendErrorInteractorOuter: AnyObject {

}

final class SendErrorInteractor {
    
    // MARK: - Properties

    weak var presenter: ISendErrorInteractorOuter?
}

// MARK: - ISendErrorInteractor

extension SendErrorInteractor: ISendErrorInteractor {

}

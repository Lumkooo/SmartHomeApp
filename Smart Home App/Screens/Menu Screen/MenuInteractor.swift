//
//  MenuInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/17/21.
//

import Foundation

protocol IMenuInteractor {
    func moveContentBackAfterMenu()
}

protocol IMenuInteractorOuter: AnyObject {

}

final class MenuInteractor {

    // MARK: - Properties

    weak var presenter: IMenuInteractorOuter?
    private let delegate: IMenuDelegate

    // MARK: - Init

    init(delegate: IMenuDelegate) {
        self.delegate = delegate
    }
}

// MARK: - IMenuInteractor

extension MenuInteractor: IMenuInteractor {
    func moveContentBackAfterMenu() {
        self.delegate.moveContentBackAfterMenu()
    }
}

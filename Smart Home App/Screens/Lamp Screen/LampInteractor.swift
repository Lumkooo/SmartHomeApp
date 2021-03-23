//
//  LampInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import Foundation

protocol ILampInteractor {

}

protocol ILampInteractorOuter: AnyObject {

}

final class LampInteractor {

    // MARK: - Properties

    weak var presenter: ILampInteractorOuter?
    private var lamp: Lamp

    // MARK: - Init

    init(lamp: Lamp) {
        self.lamp = lamp
    }
}

// MARK: - ILampInteractor

extension LampInteractor: ILampInteractor {

}

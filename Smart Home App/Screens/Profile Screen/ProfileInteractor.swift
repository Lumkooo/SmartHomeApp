//
//  ProfileInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/31/21.
//

import Foundation

protocol IProfileInteractor {

}

protocol IProfileInteractorOuter: AnyObject {

}

final class ProfileInteractor {

    // MARK: - Properties
    
    weak var presenter: IProfileInteractorOuter?
}

// MARK: - IProfileInteractor

extension ProfileInteractor: IProfileInteractor {

}

//
//  ProfileView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/31/21.
//

import UIKit

protocol IProfileView: AnyObject {

}

final class ProfileView: UIView {

    // MARK: - Views

    // MARK: - Properties

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.setupElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IProfileView

extension ProfileView: IProfileView {
    
}

// MARK: - UISetup

private extension ProfileView {
    func setupElements() {

    }
}

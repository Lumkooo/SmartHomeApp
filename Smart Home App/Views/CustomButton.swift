//
//  CustomButton.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/20/21.
//

import UIKit

final class CustomButton: UIButton {

    // MARK: - Fonts

    private enum Fonts {
        static let buttonFont = UIFont.systemFont(ofSize: 20, weight: .regular)
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .label
        self.setTitleColor(.systemBackground, for: .normal)
        self.layer.cornerRadius = AppConstants.Sizes.cornerRadius
        self.layer.shadowOpacity = AppConstants.Sizes.shadowOpacity
        self.layer.shadowRadius = AppConstants.Sizes.shadowRadius
        self.titleLabel?.font = Fonts.buttonFont
        self.layer.shadowColor = UIColor.label.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  RoundedButton.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/29/21.
//

import UIKit

final class RoundedButton: UIButton {

    // MARK: - Constants

    private enum Constants {
        static let imageMultiplier: CGFloat = 0.75
    }

    // MARK: - Init

    init(backgroundColor: UIColor = .label,
         tintColor: UIColor = .systemBackground,
         image: UIImage) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.setImage(image, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - layoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width/2
        self.setPreferredSymbolConfiguration(
            .init(pointSize: self.frame.width*Constants.imageMultiplier),
            forImageIn: .normal)
    }
}

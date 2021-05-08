//
//  AppInfoView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import UIKit

final class AppInfoView: UIView {

    // MARK: - Views

    private lazy var appIcon: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = AppConstants.Images.appIcon
        return myImageView
    }()

    private lazy var appCreatorLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.font = AppConstants.Fonts.titleLabelFont
        myLabel.textColor = .label
        myLabel.textAlignment = .center
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.minimumScaleFactor = 0.5
        myLabel.text = Localized("appInfo")
        return myLabel
    }()

    // MARK: - Properties

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.setupElements()
        self.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AppInfoView {
    func setupElements() {
        self.setupAppIcon()
        self.setupCreatorInfo()
    }

    func setupAppIcon() {
        self.addSubview(self.appIcon)
        self.appIcon.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.appIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.appIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.appIcon.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                multiplier: 0.65),
            self.appIcon.heightAnchor.constraint(equalTo: self.appIcon.widthAnchor)
        ])
    }

    func setupCreatorInfo() {
        self.addSubview(self.appCreatorLabel)
        self.appCreatorLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.appCreatorLabel.topAnchor.constraint(equalTo: self.appIcon.bottomAnchor,
                                                      constant: AppConstants.Constraints.normal),
            self.appCreatorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                      constant: AppConstants.Constraints.normal),
            self.appCreatorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                      constant: -AppConstants.Constraints.normal),
            self.appCreatorLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                      constant: -AppConstants.Constraints.normal)
        ])
    }
}

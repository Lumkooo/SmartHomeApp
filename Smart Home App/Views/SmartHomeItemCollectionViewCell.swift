//
//  SmartHomeItemCollectionViewCell.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

final class SmartHomeItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Views

    private lazy var deviceImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.tintColor = .tertiarySystemBackground
        return myImageView
    }()

    private lazy var deviceLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 2
        myLabel.font = .systemFont(ofSize: 20, weight: .light)
        myLabel.textAlignment = .center
        return myLabel
    }()

    private lazy var deviceStateLabel: UILabel = {
        let myLabel = UILabel()
        return myLabel
    }()

    // MARK: - Properties

    private(set) var device: SmartHomeDevice?
    static let reuseIdentifier = String(describing: self)


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .secondarySystemBackground
        self.setupElements()
        self.setupLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public method

    func setupCell(device: SmartHomeDevice) {
        self.device = device
        self.deviceLabel.text = device.name
        self.deviceImageView.image = device.image

        self.deviceStateLabel.text = device.isTurnedOn ? "Включено" : "Отключено"
        self.deviceStateLabel.textColor = device.isTurnedOn ? UIColor.systemGreen : UIColor.label
    }
}

// MARK: - UISetup

private extension SmartHomeItemCollectionViewCell {
    func setupElements() {
        self.setupDeviceImageView()
        self.setupDeviceLabel()
        self.setupDeviceStateLabel()
    }

    func setupDeviceImageView() {
        self.contentView.addSubview(self.deviceImageView)
        self.deviceImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.deviceImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                          constant: AppConstants.Constraints.normal),
            self.deviceImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                           constant: -AppConstants.Constraints.normal),
            self.deviceImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                                      constant: AppConstants.Constraints.twice),
            self.deviceImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                         constant: -AppConstants.Constraints.twice)
        ])
    }

    func setupDeviceLabel() {
        self.contentView.addSubview(self.deviceLabel)
        self.deviceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.deviceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.deviceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.deviceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                     constant: -AppConstants.Constraints.half)
        ])
    }

    func setupDeviceStateLabel() {
        self.contentView.addSubview(self.deviceStateLabel)
        self.deviceStateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.deviceStateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                            constant: -AppConstants.Constraints.quarter),
            self.deviceStateLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                                            constant: AppConstants.Constraints.quarter)
        ])
    }

    func setupLayer() {
        self.layer.cornerRadius = AppConstants.Sizes.cornerRadius
        self.layer.borderWidth = AppConstants.Sizes.borderWidth
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true

        self.contentView.layer.cornerRadius = AppConstants.Sizes.cornerRadius
        self.contentView.layer.borderWidth = AppConstants.Sizes.borderWidth
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.label.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = AppConstants.Sizes.shadowRadius
        self.layer.shadowOpacity = AppConstants.Sizes.shadowOpacity
        self.layer.cornerRadius = AppConstants.Sizes.cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}

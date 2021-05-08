//
//  SimpleDeviceView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import UIKit

protocol ISimpleDeviceView: AnyObject {
    var toggleButtonTapped: (() -> Void)? { get set }

    func prepareView(device: SmartHomeDevice)
    func reloadStateOfDevice(_ device: SmartHomeDevice)
}

final class SimpleDeviceView: UIView {

    // MARK: - Views

    private lazy var toggleStateLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.textAlignment = .center
        myLabel.font = AppConstants.Fonts.deviceLabel
        return myLabel
    }()

    private lazy var toggleStateButton: RoundedButton = {
        let myButton = RoundedButton(image: AppConstants.Images.power)
        myButton.addTarget(self,
                           action: #selector(self.toggleStateButtonTapped),
                           for: .touchUpInside)
        return myButton
    }()

    // MARK: - Properties

    var toggleButtonTapped: (() -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.setupElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Обработка нажатия на кнопку

    @objc private func toggleStateButtonTapped() {
        self.toggleButtonTapped?()
    }
}

// MARK: - ISimpleDeviceView

extension SimpleDeviceView: ISimpleDeviceView {
    func prepareView(device: SmartHomeDevice) {
        self.setupStateOfDevice(device)
    }

    func reloadStateOfDevice(_ device: SmartHomeDevice) {
        self.setupStateOfDevice(device)
    }
}

// MARK: - UISetup

private extension SimpleDeviceView {
    func setupElements() {
        self.setupToggleStateButton()
        self.setupToggleStateLabel()
    }

    func setupToggleStateButton() {
        self.addSubview(self.toggleStateButton)
        self.toggleStateButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.toggleStateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.toggleStateButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.toggleStateButton.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                          multiplier: 0.35),
            self.toggleStateButton.heightAnchor.constraint(equalTo: self.widthAnchor,
                                                           multiplier: 0.35)
        ])
    }

    func setupToggleStateLabel() {
        self.addSubview(self.toggleStateLabel)
        self.toggleStateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.toggleStateLabel.centerXAnchor.constraint(equalTo: self.toggleStateButton.centerXAnchor),
            self.toggleStateLabel.bottomAnchor.constraint(equalTo: self.toggleStateButton.topAnchor,
                                                          constant: -AppConstants.Constraints.normal),
        ])
    }
}

private extension SimpleDeviceView {
    func setupStateOfDevice(_ device: SmartHomeDevice) {
        let text = device.isTurnedOn ? Localized("turnOn") : Localized("turnOff")
        self.toggleStateLabel.text = text
    }
}

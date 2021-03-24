//
//  LampView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import UIKit

protocol ILampView: AnyObject {
    var toggleLamp: (() -> Void)? { get set }
    var sliderDidChangeValue: ((Int) -> Void)? { get set }

    func prepareView(lamp: Lamp)
}

final class LampView: UIView, UITextViewDelegate {

    // MARK: - Constants

    private enum Constants {
        static let customSliderWidthMultiplier: CGFloat = 0.4
        static let lightLevelLabelFont = UIFont.systemFont(ofSize: 23, weight: .semibold)
    }

    // MARK: - Views

    private lazy var lightLevelLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.numberOfLines = 0
        myLabel.textAlignment = .center
        myLabel.font = Constants.lightLevelLabelFont
        return myLabel
    }()

    private lazy var customSlider: CustomSlider = {
        let myCustomSlider = CustomSlider()
        return myCustomSlider
    }()

    private lazy var toggleStateButton: UIButton = {
        let myButton = UIButton()
        myButton.backgroundColor = .label
        myButton.tintColor = .systemBackground
        myButton.setImage(AppConstants.Images.power, for: .normal)
        myButton.addTarget(self,
                           action: #selector(self.toggleStateButtonTapped),
                           for: .touchUpInside)
        return myButton
    }()

    // MARK: - Properties

    var toggleLamp: (() -> Void)?
    var sliderDidChangeValue: ((Int) -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.setupElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - layoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        self.toggleStateButton.layer.cornerRadius = self.toggleStateButton.frame.width/2
    }

    // MARK: - Обработка нажатий на кнопку

    @objc private func toggleStateButtonTapped() {
        self.toggleLamp?()
    }
}

// MARK: - ILampView

extension LampView: ILampView {
    func prepareView(lamp: Lamp) {
        self.customSlider.isUserInteractionEnabled = lamp.isTurnedOn
        if lamp.isTurnedOn {
            self.setLightLevel(level: lamp.lightLevel)
        } else {
            self.setLightLevelLabelText(isTurnedOn: lamp.isTurnedOn)
        }
    }
}

// MARK: - UISetup

private extension LampView {
    func setupElements() {
        self.setupLightLevelLabel()
        self.setupCustomSlider()
        self.setupToggleStateButton()
    }

    func setupLightLevelLabel() {
        self.addSubview(self.lightLevelLabel)
        self.lightLevelLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.lightLevelLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.lightLevelLabel.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: AppConstants.Constraints.normal)
        ])
    }

    func setupCustomSlider() {
        self.addSubview(self.customSlider)
        self.customSlider.translatesAutoresizingMaskIntoConstraints = false
        self.customSlider.delegate = self

        
        NSLayoutConstraint.activate([
            self.customSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.customSlider.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: Constants.customSliderWidthMultiplier),
            self.customSlider.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -AppConstants.Constraints.normal),
            self.customSlider.topAnchor.constraint(
                equalTo: self.lightLevelLabel.bottomAnchor,
                constant: AppConstants.Constraints.normal)
        ])
    }

    func setupToggleStateButton() {
        self.addSubview(self.toggleStateButton)
        self.toggleStateButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.toggleStateButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                             constant: -AppConstants.Constraints.normal),
            self.toggleStateButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.toggleStateButton.leadingAnchor.constraint(equalTo: self.customSlider.trailingAnchor,
                                                            constant: AppConstants.Constraints.normal),
            self.toggleStateButton.heightAnchor.constraint(equalTo: self.toggleStateButton.widthAnchor)
        ])
    }
}

// MARK: - ICustomSlider

extension LampView: ICustomSlider {
    func sliderDidChangeValue(customSlider: CustomSlider, value: Int) {
        self.sliderDidChangeValue?(value)
    }
}

// MARK: - Работа с кастомным слайдером

private extension LampView {
    func setLightLevel(level: Int) {
        self.customSlider.setSliderLevel(level: level)
        self.setLightLevelLabelText(level: level)
    }

    func setLightLevelLabelText(level: Int = 0, isTurnedOn: Bool = true) {
        if isTurnedOn {
            self.lightLevelLabel.text = "Устройство включено!\nУровень яркости устройства:\n\(level)"
        } else {
            self.lightLevelLabel.text = "Устройство выключено!"
        }
    }
}

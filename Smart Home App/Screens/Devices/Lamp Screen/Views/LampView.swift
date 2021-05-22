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
    var sliderDidEndGesture: ((Int) -> Void)? { get set }
    var colorChangeButtonPressed: (() -> Void)? { get set }

    func prepareView(lamp: Lamp)
    func changeLampInfo(lamp: Lamp)
    func changeLightColorTo(_ color: UIColor)
    func changeLightLevelTo(_ level: Int)
}

final class LampView: UIView, UITextViewDelegate {

    // MARK: - Views

    private let customSlider = CustomSlider()

    private lazy var toggleStateLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.textAlignment = .center
        myLabel.font = AppConstants.Fonts.deviceLabel
        return myLabel
    }()

    private lazy var toggleStateButton: RoundedButton = {
        let myRoundedButton = RoundedButton(backgroundColor: .label,
                                     tintColor: .systemBackground,
                                     image: AppConstants.Images.power)
        myRoundedButton.addTarget(self,
                           action: #selector(self.toggleStateButtonTapped),
                           for: .touchUpInside)
        return myRoundedButton
    }()

    private lazy var lightColorLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.numberOfLines = 0
        myLabel.textAlignment = .center
        myLabel.text = Localized("color")
        myLabel.font = AppConstants.Fonts.deviceLabel
        return myLabel
    }()

    private lazy var changeLightColorButton: RoundedButton = {
        let myRoundedButton = RoundedButton(backgroundColor: .label,
                                     tintColor: .white,
                                     image: AppConstants.Images.circleFill)
        myRoundedButton.addTarget(self,
                           action: #selector(self.changeLightColorButtonTapped),
                           for: .touchUpInside)
        return myRoundedButton
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let myActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        myActivityIndicatorView.color = .label
        myActivityIndicatorView.hidesWhenStopped = true
        myActivityIndicatorView.startAnimating()
        return myActivityIndicatorView
    }()

    // MARK: - Properties

    var toggleLamp: (() -> Void)?
    var sliderDidChangeValue: ((Int) -> Void)?
    var colorChangeButtonPressed: (() -> Void)?
    var sliderDidEndGesture: ((Int) -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.setupActivityIndicatorView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Обработка нажатий на кнопку

    @objc private func toggleStateButtonTapped() {
        self.toggleLamp?()
    }

    @objc private func changeLightColorButtonTapped() {
        self.colorChangeButtonPressed?()
    }
}

// MARK: - ILampView

extension LampView: ILampView {
    func prepareView(lamp: Lamp) {
        self.setupElements()
        self.activityIndicatorView.stopAnimating()

        // Не могу понять почему без хотя бы малейшего ожидания на customSlider
        // не выставляется значение уровня...
        DispatchQueue.main.asyncAfter(deadline: .now()+0.001) {
            self.changeLampInfo(lamp: lamp)
        }
    }

    func changeLampInfo(lamp: Lamp) {
        self.customSlider.isUserInteractionEnabled = lamp.isTurnedOn
        if lamp.isTurnedOn {
            self.setLightLevel(level: lamp.lightLevel)
        }
        self.changeLightColorButton.isUserInteractionEnabled = lamp.isTurnedOn
        self.setLightColor(color: lamp.lightColor)
        self.setLampState(lamp.isTurnedOn)
    }

    func changeLightColorTo(_ color: UIColor) {
        self.setLightColor(color: color)
    }

    func changeLightLevelTo(_ level: Int) {
        self.setLightLevel(level: level)
    }
}

// MARK: - UISetup

private extension LampView {

    func setupActivityIndicatorView() {
        self.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    func setupElements() {
        self.setupCustomSlider()
        self.setupToggleStateButton()
        self.setupToggleStateLabel()
        self.setupChangeLightColorButton()
        self.setupLightColorLabel()
    }

    func setupCustomSlider() {
        self.addSubview(self.customSlider)
        self.customSlider.translatesAutoresizingMaskIntoConstraints = false
        self.customSlider.delegate = self
        
        NSLayoutConstraint.activate([
            self.customSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.customSlider.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: AppConstants.Sizes.customSliderWidthMultiplier),
            self.customSlider.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -AppConstants.Constraints.normal),
            self.customSlider.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
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

    func setupToggleStateLabel() {
        self.addSubview(self.toggleStateLabel)
        self.toggleStateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.toggleStateLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -AppConstants.Constraints.quarter),
            self.toggleStateLabel.leadingAnchor.constraint(
                equalTo: self.customSlider.trailingAnchor,
                constant: AppConstants.Constraints.quarter),
            self.toggleStateLabel.bottomAnchor.constraint(equalTo: self.toggleStateButton.topAnchor,
                                                         constant: -AppConstants.Constraints.normal)
        ])
    }

    func setupChangeLightColorButton() {
        self.addSubview(self.changeLightColorButton)
        self.changeLightColorButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.changeLightColorButton.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: AppConstants.Constraints.normal),
            self.changeLightColorButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.changeLightColorButton.trailingAnchor.constraint(
                equalTo: self.customSlider.leadingAnchor,
                constant: -AppConstants.Constraints.normal),
            self.changeLightColorButton.heightAnchor.constraint(equalTo: self.toggleStateButton.widthAnchor)
        ])
    }

    func setupLightColorLabel() {
        self.addSubview(self.lightColorLabel)
        self.lightColorLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.lightColorLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: AppConstants.Constraints.quarter),
            self.lightColorLabel.trailingAnchor.constraint(
                equalTo: self.customSlider.leadingAnchor,
                constant: -AppConstants.Constraints.quarter),
            self.lightColorLabel.bottomAnchor.constraint(equalTo: self.changeLightColorButton.topAnchor,
                                                         constant: -AppConstants.Constraints.normal)
        ])
    }
}

// MARK: - ICustomSlider

extension LampView: ICustomSlider {
    func sliderDidEndDragging(customSlider: CustomSlider, value: Int) {
        self.sliderDidEndGesture?(value)
    }

    func sliderDidChangeValue(customSlider: CustomSlider, value: Int) {
        self.sliderDidChangeValue?(value)
    }
}

// MARK: - Работа с кастомным слайдером

private extension LampView {
    func setLightLevel(level: Int) {
        self.customSlider.setSliderLevel(level: level)
    }
}

private extension LampView {
    func setLightColor(color: UIColor) {
        self.changeLightColorButton.tintColor = color
    }

    func setLampState(_ state: Bool) {
        let text = state ? Localized("turnOn") : Localized("turnOff")
        self.toggleStateLabel.text = text
    }
}

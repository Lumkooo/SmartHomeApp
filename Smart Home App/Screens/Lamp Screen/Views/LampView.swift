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
    var colorChangeButtonPressed: (() -> Void)? { get set }

    func prepareView(lamp: Lamp)
    func changeLightColorTo(_ color: UIColor)
    func changeLightLevelTo(_ level: Int)
}

final class LampView: UIView, UITextViewDelegate {

    // MARK: - Constants

    private enum Constants {
        static let customSliderWidthMultiplier: CGFloat = 0.4
        static let lightLevelLabelFont = UIFont.systemFont(ofSize: 23, weight: .semibold)
        static let lightColorFont = UIFont.systemFont(ofSize: 18, weight: .light)
        static let changeLightColorButtonPreferredSymbolConfigationMultiplier: CGFloat = 0.75
    }

    // MARK: - Views

    private let customSlider = CustomSlider()

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

    private lazy var lightColorLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.numberOfLines = 0
        myLabel.textAlignment = .center
        myLabel.text = "Цвет:"
        myLabel.font = Constants.lightColorFont
        return myLabel
    }()

    private lazy var changeLightColorButton: UIButton = {
        let myButton = UIButton()
        myButton.backgroundColor = .label
        myButton.tintColor = .white
        myButton.setImage(AppConstants.Images.circleFill, for: .normal)
        myButton.addTarget(self,
                           action: #selector(self.changeLightColorButtonTapped),
                           for: .touchUpInside)
        return myButton
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

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.setupActivityIndicatorView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - layoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        self.toggleStateButton.layer.cornerRadius = self.toggleStateButton.frame.width/2
        self.changeLightColorButton.layer.cornerRadius = self.changeLightColorButton.frame.width/2

        self.changeLightColorButton.setPreferredSymbolConfiguration(
            .init(pointSize: self.changeLightColorButton.frame.width*Constants.changeLightColorButtonPreferredSymbolConfigationMultiplier),
            forImageIn: .normal)
    }

    // MARK: - Обработка нажатий на кнопку

    @objc private func toggleStateButtonTapped() {
        self.toggleLamp?()
    }

    @objc private func changeLightColorButtonTapped() {
        // TODO: - Смена цвета
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
            self.customSlider.isUserInteractionEnabled = lamp.isTurnedOn
            if lamp.isTurnedOn {
                self.setLightLevel(level: lamp.lightLevel)
            }
            self.changeLightColorButton.isUserInteractionEnabled = lamp.isTurnedOn
            self.setLightColor(color: lamp.lightColor)
        }
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
                multiplier: Constants.customSliderWidthMultiplier),
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
                constant: AppConstants.Constraints.normal),
            self.lightColorLabel.trailingAnchor.constraint(
                equalTo: self.customSlider.leadingAnchor,
                constant: -AppConstants.Constraints.normal),
            self.lightColorLabel.bottomAnchor.constraint(equalTo: self.changeLightColorButton.topAnchor,
                                                         constant: -AppConstants.Constraints.normal)
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
        print("Size: ", self.customSlider.frame.height)
        self.customSlider.setSliderLevel(level: level)
    }
}

private extension LampView {
    func setLightColor(color: UIColor) {
        self.changeLightColorButton.tintColor = color
    }
}

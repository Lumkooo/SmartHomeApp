//
//  AirConditionerView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/13/21.
//

import UIKit

protocol IAirConditionerView: AnyObject {
    var toggleAirConditioner: (() -> Void)? { get set }
    var sliderDidChangeValue: ((Int) -> Void)? { get set }

    func changeSliderValueTo(_ value: Int)
    func prepareView(airConditioner: AirConditioner)
    func changeAirConditionerInfo(airConditioner: AirConditioner)
}

final class AirConditionerView: UIView {

    // MARK: - Views

    private let customSlider = CustomSlider()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let myActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        myActivityIndicatorView.color = .label
        myActivityIndicatorView.hidesWhenStopped = true
        myActivityIndicatorView.startAnimating()
        return myActivityIndicatorView
    }()

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

    private let minimumTempratureLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.font = AppConstants.Fonts.deviceLabel
        myLabel.numberOfLines = 0
        return myLabel
    }()

    private let maximumTempratureLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.font = AppConstants.Fonts.deviceLabel
        return myLabel
    }()

    private lazy var currentTempratureLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .label
        myLabel.font = AppConstants.Fonts.deviceSmallLabel
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0
        return myLabel
    }()

    // MARK: - Properties

    var toggleAirConditioner: (() -> Void)?
    var sliderDidChangeValue: ((Int) -> Void)?
    private let tempraturePrefix: String = "Температура:\n"
    private let tempratureSuffix: String = "°С"

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
        self.toggleAirConditioner?()
    }
}

// MARK: - IAirConditionerView

extension AirConditionerView: IAirConditionerView {
    func prepareView(airConditioner: AirConditioner) {
        self.setupElements()
        self.activityIndicatorView.stopAnimating()

        // Не могу понять почему без хотя бы малейшего ожидания на customSlider
        // не выставляется значение уровня...
        DispatchQueue.main.asyncAfter(deadline: .now()+0.001) {
            self.changeAirConditionerInfo(airConditioner: airConditioner)
        }
        self.minimumTempratureLabel.text = "\(airConditioner.minimumTemprature)°С"
        self.maximumTempratureLabel.text = "\(airConditioner.maximumTemprature)°С"
    }

    func changeAirConditionerInfo(airConditioner: AirConditioner) {
        self.customSlider.isUserInteractionEnabled = airConditioner.isTurnedOn
        if airConditioner.isTurnedOn {
            self.currentTempratureLabel.isHidden = false
            self.setTempratureLevel(level: airConditioner.temperatureLevel)
        } else {
            self.currentTempratureLabel.isHidden = true
        }
        self.setAirConditionerState(airConditioner.isTurnedOn)
    }

    func changeSliderValueTo(_ value: Int) {
        self.setTempratureLevel(level: value)
    }
}

// MARK: - UISetup

private extension AirConditionerView {
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
        self.setupMinimumTempratureLabel()
        self.setupMaximumTempratureLabel()
        self.setupCurrentTempratureLabel()
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

    func setupMinimumTempratureLabel() {
        self.addSubview(self.minimumTempratureLabel)
        self.minimumTempratureLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.minimumTempratureLabel.bottomAnchor.constraint(equalTo: self.customSlider.bottomAnchor,
                                                                constant: -AppConstants.Constraints.half),
            self.minimumTempratureLabel.trailingAnchor.constraint(equalTo: self.customSlider.leadingAnchor,
                                                                  constant: -AppConstants.Constraints.half)
        ])
    }

    func setupMaximumTempratureLabel() {
        self.addSubview(self.maximumTempratureLabel)
        self.maximumTempratureLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.maximumTempratureLabel.topAnchor.constraint(equalTo: self.customSlider.topAnchor,
                                                                constant: AppConstants.Constraints.half),
            self.maximumTempratureLabel.trailingAnchor.constraint(equalTo: self.customSlider.leadingAnchor,
                                                                  constant: -AppConstants.Constraints.half)
        ])
    }

    func setupCurrentTempratureLabel() {
        self.addSubview(self.currentTempratureLabel)
        self.currentTempratureLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.currentTempratureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                 constant: AppConstants.Constraints.quarter),
            self.currentTempratureLabel.trailingAnchor.constraint(equalTo: self.customSlider.leadingAnchor,
                                                                  constant: -AppConstants.Constraints.quarter),
            self.currentTempratureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

// MARK: - ICustomSlider

extension AirConditionerView: ICustomSlider {
    func sliderDidChangeValue(customSlider: CustomSlider, value: Int) {
        self.sliderDidChangeValue?(value)
    }
}

// MARK: - Работа с кастомным слайдером

private extension AirConditionerView {
    func setTempratureLevel(level: Int) {
        self.customSlider.setSliderLevel(level: level)
        let celsiumDegrees = self.temperatureLevelToTemprature(level)
        self.currentTempratureLabel.text = self.tempraturePrefix+String(celsiumDegrees)+self.tempratureSuffix
    }

    func setAirConditionerState(_ state: Bool) {
        let text = state ? "Включено!" : "Выключено!"
        self.toggleStateLabel.text = text
    }

    func temperatureLevelToTemprature(_ tempratureLevel: Int,
                                      minimumTemperature: Int = 5,
                                      maximumTemperature: Int = 35) -> Int {
        return minimumTemperature + (tempratureLevel*(maximumTemperature-minimumTemperature))/100
    }
}

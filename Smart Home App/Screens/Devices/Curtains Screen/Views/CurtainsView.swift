//
//  CurtainsView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/10/21.
//

import UIKit

protocol ICurtainsView: AnyObject {
    var toggleCurtains: (() -> Void)? { get set }
    var sliderDidChangeValue: ((Int) -> Void)? { get set }
    var sliderDidEndGesture: ((Int) -> Void)? { get set }

    func prepareView(curtains: Curtains)
    func changeInfo(curtains: Curtains)
    func changetLevelTo(_ level: Int)
}

final class CurtainsView: UIView, UITextViewDelegate {

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

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let myActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        myActivityIndicatorView.color = .label
        myActivityIndicatorView.hidesWhenStopped = true
        myActivityIndicatorView.startAnimating()
        return myActivityIndicatorView
    }()

    // MARK: - Properties

    var toggleCurtains: (() -> Void)?
    var sliderDidChangeValue: ((Int) -> Void)?
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
        self.toggleCurtains?()
    }
}

// MARK: - ICurtainsView

extension CurtainsView: ICurtainsView {
    func changetLevelTo(_ level: Int) {
        self.setLevel(level: level)
    }
    
    func prepareView(curtains: Curtains) {
        self.setupElements()
        self.activityIndicatorView.stopAnimating()

        // Не могу понять почему без хотя бы малейшего ожидания на customSlider
        // не выставляется значение уровня...
        DispatchQueue.main.asyncAfter(deadline: .now()+0.001) {
            self.changeInfo(curtains: curtains)
        }
    }

    func changeInfo(curtains: Curtains) {
        self.customSlider.isUserInteractionEnabled = curtains.isTurnedOn
        if curtains.isTurnedOn {
            self.setLevel(level: curtains.level)
        }
        self.setState(curtains.isTurnedOn)
    }
}

// MARK: - UISetup

private extension CurtainsView {

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
}

// MARK: - ICustomSlider

extension CurtainsView: ICustomSlider {
    func sliderDidEndDragging(customSlider: CustomSlider, value: Int) {
        self.sliderDidEndGesture?(value)
    }

    func sliderDidChangeValue(customSlider: CustomSlider, value: Int) {
        self.sliderDidChangeValue?(value)
    }
}

// MARK: - Работа с кастомным слайдером

private extension CurtainsView {
    func setLevel(level: Int) {
        self.customSlider.setSliderLevel(level: level)
    }
}

private extension CurtainsView {
    func setState(_ state: Bool) {
        let text = state ? Localized("turnOn") : Localized("turnOff")
        self.toggleStateLabel.text = text
    }
}

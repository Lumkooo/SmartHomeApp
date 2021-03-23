//
//  CustomSlider.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import UIKit

protocol ICustomSlider {
    func sliderDidChangeValue(customSlider: CustomSlider, value: Int)
}


final class CustomSlider: UIView {

    // MARK: - Constants

    private enum Constants {
        static let widthMultiplier: CGFloat = 0.4
        static let sliderMinimumValue: CGFloat = 0
        static let sliderMaximumValue: CGFloat = 100
    }

    // MARK: - Views

    private lazy var customSliderBackgroundView: UIView = {
        let myView = UIView()
        myView.layer.cornerRadius = 2*AppConstants.Sizes.cornerRadius
        myView.backgroundColor = .systemGray3
        myView.clipsToBounds = true
        return myView
    }()

    private lazy var customSliderView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .systemGray6
        return myView
    }()

    // MARK: - Properties

    var delegate: ICustomSlider?
    private lazy var customSliderViewTopAnchor = self.customSliderView.topAnchor.constraint(
        equalTo: self.safeAreaLayoutGuide.topAnchor,
        constant: AppConstants.Constraints.normal)
    private var translationTemproraryValue: CGPoint = CGPoint(x: 0, y: 0)

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.setupElements()
        self.setupPanGesture()
    }

    convenience init(sliderColor: UIColor, sliderBackgroundColor: UIColor) {
        self.init()
        self.customSliderView.backgroundColor = sliderColor
        self.customSliderBackgroundView.backgroundColor = sliderBackgroundColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Обработка жестов

    private func setupPanGesture() {
        let slide = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
        let secondSlide = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
        self.customSliderView.addGestureRecognizer(slide)
        self.customSliderBackgroundView.addGestureRecognizer(secondSlide)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer? = nil) {

        guard let gesture = gesture else {
            return
        }

        // Обработка состояний жеста
        switch gesture.state {
        case .cancelled, .ended:
            // При завершении жеста необходимо запомнить текущее состояние, чтобы
            // потом продолжить с него
            self.translationTemproraryValue = gesture.translation(in: self)
        case .began:
            // Продолжаем с состояния, которое запомнили выше
            gesture.setTranslation(self.translationTemproraryValue, in: self)
        default:
            break
        }

        let translationY = gesture.translation(in: self).y

        // Проверка на граничные условия
        if translationY < 0 {
            gesture.setTranslation(CGPoint(x: 0, y: 0),
                                   in: self)
        } else if translationY >= self.safeAreaLayoutGuide.layoutFrame.height {
            gesture.setTranslation(CGPoint(x: 0, y: self.safeAreaLayoutGuide.layoutFrame.height),
                                   in: self)
        }

        self.customSliderViewTopAnchor.constant = translationY

        // Расчет числового значения слайдера
        var sliderLevel = ((self.customSliderBackgroundView.frame.height - translationY) / self.customSliderBackgroundView.frame.height) * Constants.sliderMaximumValue

        // Обработка граничных условий
        if sliderLevel > Constants.sliderMaximumValue {
            sliderLevel = Constants.sliderMaximumValue
        } else if sliderLevel < Constants.sliderMinimumValue {
            sliderLevel = Constants.sliderMinimumValue
        }

        // вызов метода sliderDidChangeValue у делегата
        self.delegate?.sliderDidChangeValue(customSlider: self,
                                            value: Int(sliderLevel))
    }
}

// MARK: - UISetup

private extension CustomSlider {
    func setupElements() {
        self.setupCustomSliderBackgroundView()
    }

    func setupCustomSliderBackgroundView() {
        self.addSubview(self.customSliderBackgroundView)
        self.customSliderBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.customSliderBackgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.customSliderBackgroundView.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: Constants.widthMultiplier),
            self.customSliderBackgroundView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -AppConstants.Constraints.normal),
            self.customSliderBackgroundView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: AppConstants.Constraints.normal)
        ])
        self.setupCustomSliderView()
    }

    func setupCustomSliderView() {
        self.customSliderBackgroundView.addSubview(self.customSliderView)
        self.customSliderView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.customSliderView.leadingAnchor.constraint(equalTo: self.customSliderBackgroundView.leadingAnchor),
            self.customSliderView.trailingAnchor.constraint(equalTo: self.customSliderBackgroundView.trailingAnchor),
            self.customSliderView.bottomAnchor.constraint(equalTo: self.customSliderBackgroundView.bottomAnchor),
            self.customSliderViewTopAnchor
        ])
    }
}

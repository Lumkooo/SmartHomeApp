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
        equalTo: self.topAnchor,
        constant: AppConstants.Constraints.normal)
    private var translationTemproraryValue: CGPoint = CGPoint(x: 0, y: 0)
    override var isUserInteractionEnabled: Bool {
        didSet {
            if self.isUserInteractionEnabled {
                self.setupPanGesture()
            } else {
                self.disablePanGesture()
            }
        }
    }

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.setupElements()
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

    private func disablePanGesture() {
        if let gestures = self.customSliderView.gestureRecognizers {
            for gesture in gestures {
                self.customSliderView.removeGestureRecognizer(gesture)
            }
        }
        if let gestures = self.customSliderBackgroundView.gestureRecognizers {
            for gesture in gestures {
                self.customSliderBackgroundView.removeGestureRecognizer(gesture)
            }
        }
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

        // Проверка на граничные условия
        if translationY < 0 {
            gesture.setTranslation(CGPoint(x: 0, y: 0),
                                   in: self)
            return
        } else if translationY >= self.customSliderBackgroundView.frame.height {
            gesture.setTranslation(CGPoint(x: 0, y: self.customSliderBackgroundView.frame.height),
                                   in: self)
            return
        }

        self.customSliderViewTopAnchor.constant = translationY

        // Расчет числового значения слайдера
    }

    // MARK: - Public method

    /// Выставляет уровень слайдера к заданному level-у.
    /// (Значение level должно быть в пределах от 0 до 100)
    func setSliderLevel(level: Int) {

        // Выход за пределы возможного уровня
        if level < 0 || level > 100 {
            return
        }

        // Находим нужное положение уровня на customSliderView
        let translationValue = (Int(self.customSliderBackgroundView.frame.height) * (100-level))/100

        // Выставляем translationTemproraryValue для дальнейшей работы со слайдером с этого места
        // и выставляет верхний constraint customSliderView равным self.translationTemproraryValue.y
        self.translationTemproraryValue = CGPoint(x: 0, y: translationValue)
        self.customSliderViewTopAnchor.constant = self.translationTemproraryValue.y
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
            self.customSliderBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.customSliderBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.customSliderBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.customSliderBackgroundView.topAnchor.constraint(equalTo: self.topAnchor)
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

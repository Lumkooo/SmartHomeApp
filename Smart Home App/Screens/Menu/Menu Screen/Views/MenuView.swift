//
//  MenuView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/17/21.
//

import UIKit

protocol IMenuView: AnyObject {
    var closeButtonTapped: (() -> Void)? { get set }
    var getAppInfoTapped: (() -> Void)? { get set }
    var sendErrorTapped: (() -> Void)? { get set }
    var moveBackScreenContentBack: (() -> Void)? { get set }

    func slideView()
}

final class MenuView: UIView {

    // MARK: - Views

    private lazy var slidingMenuView: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.tertiarySystemGroupedBackground
        return myView
    }()

    private lazy var closeButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(AppConstants.Images.xmark,
                          for: .normal)
        myButton.tintColor = .label
        myButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        return myButton
    }()

    private lazy var tapToCloseView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .clear
        return myView
    }()

    private let getAppInfoButton: CustomButton = {
        let myButton = CustomButton()
        myButton.setTitle(Localized("getAppInfo"), for: .normal)
        myButton.titleLabel?.minimumScaleFactor = 0.5
        myButton.titleLabel?.adjustsFontSizeToFitWidth = true
        myButton.addTarget(self,
                           action: #selector(getAppInfoTapped(gesture:)),
                           for: .touchUpInside)
        return myButton
    }()

    private let sendErrorButton: CustomButton = {
        let myButton = CustomButton()
        myButton.setTitle(Localized("sendError"), for: .normal)
        myButton.titleLabel?.minimumScaleFactor = 0.5
        myButton.titleLabel?.adjustsFontSizeToFitWidth = true
        myButton.addTarget(self,
                           action: #selector(sendErrorTapped(gesture:)),
                           for: .touchUpInside)
        return myButton
    }()

    // MARK: - Properties

    var closeButtonTapped: (() -> Void)?
    var moveBackScreenContentBack: (() -> Void)?
    var getAppInfoTapped: (() -> Void)?
    var sendErrorTapped: (() -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.setupElements()
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.setupTapToClose()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Обработка нажатия на кнопку

    @objc private func buttonSelector() {
        self.hideMenu {
            self.closeButtonTapped?()
        }
    }

    @objc func viewTapped(_ panRecognizer: UIPanGestureRecognizer) {
        self.hideMenu {
            self.closeButtonTapped?()
        }
    }

    // MARK: - Private

    private func hideMenu(withAction action: (()-> Void)?) {
        self.moveBackScreenContentBack?()
        UIView.animate(withDuration: AppConstants.AnimationTime.menuAnimationTime) {
            self.backgroundColor = UIColor(white: 1, alpha: 0)
            self.slidingMenuView.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { (bool) in
            action?()
        }
    }

    private func setupTapToClose() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        self.tapToCloseView.addGestureRecognizer(viewTap)
    }

    @objc private func getAppInfoTapped(gesture: UIGestureRecognizer) {
        self.hideMenu {
            self.getAppInfoTapped?()
        }
    }

    @objc private func sendErrorTapped(gesture: UIGestureRecognizer) {
        self.hideMenu {
            self.sendErrorTapped?()
        }
    }
}

// MARK: - IMenuView

extension MenuView: IMenuView {
    func slideView() {
        UIView.animate(withDuration: AppConstants.AnimationTime.menuAnimationTime) {
            self.backgroundColor = UIColor.white.withAlphaComponent(0.65)
            self.slidingMenuView.transform = CGAffineTransform(translationX: -self.slidingMenuView.frame.width,
                                                               y: 0)
        }
    }
}

// MARK: - UISetup

private extension MenuView {
    func setupElements() {
        self.setupSlidingMenuView()
        self.setupCloseButton()
        self.setupTapToCloseView()
        self.setupGetAppInfoButton()
        self.setupSendErorrButton()
    }

    func setupSlidingMenuView() {
        self.addSubview(self.slidingMenuView)
        self.slidingMenuView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.slidingMenuView.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                        multiplier: AppConstants.Sizes.menuWidth),
            self.slidingMenuView.leadingAnchor.constraint(equalTo: self.trailingAnchor),
            self.slidingMenuView.topAnchor.constraint(equalTo: self.topAnchor),
            self.slidingMenuView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setupCloseButton() {
        self.slidingMenuView.addSubview(self.closeButton)
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.closeButton.trailingAnchor.constraint(equalTo: self.slidingMenuView.trailingAnchor,
                                           constant: -AppConstants.Constraints.half),
            self.closeButton.topAnchor.constraint(equalTo: self.slidingMenuView.safeAreaLayoutGuide.topAnchor,
                                           constant: AppConstants.Constraints.half),
            self.closeButton.widthAnchor.constraint(equalToConstant: AppConstants.Sizes.closeButtonSize.width),
            self.closeButton.heightAnchor.constraint(equalToConstant: AppConstants.Sizes.closeButtonSize.height)
        ])
    }

    func setupTapToCloseView() {
        self.addSubview(self.tapToCloseView)
        self.tapToCloseView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tapToCloseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tapToCloseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tapToCloseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.tapToCloseView.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                       multiplier: 1-AppConstants.Sizes.menuWidth),
        ])
    }

    func setupGetAppInfoButton() {
        self.slidingMenuView.addSubview(self.getAppInfoButton)
        self.getAppInfoButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.getAppInfoButton.leadingAnchor.constraint(equalTo: self.slidingMenuView.leadingAnchor,
                                                           constant: AppConstants.Constraints.normal),
            self.getAppInfoButton.trailingAnchor.constraint(equalTo: self.slidingMenuView.trailingAnchor,
                                                           constant: -AppConstants.Constraints.normal),
            self.getAppInfoButton.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor,
                                                           constant: AppConstants.Constraints.twice),
            self.getAppInfoButton.heightAnchor.constraint(equalToConstant: AppConstants.Sizes.closeButtonSize.height)
        ])
    }


    func setupSendErorrButton() {
        self.slidingMenuView.addSubview(self.sendErrorButton)
        self.sendErrorButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.sendErrorButton.leadingAnchor.constraint(equalTo: self.slidingMenuView.leadingAnchor,
                                                           constant: AppConstants.Constraints.normal),
            self.sendErrorButton.trailingAnchor.constraint(equalTo: self.slidingMenuView.trailingAnchor,
                                                           constant: -AppConstants.Constraints.normal),
            self.sendErrorButton.topAnchor.constraint(equalTo: self.getAppInfoButton.bottomAnchor,
                                                           constant: AppConstants.Constraints.twice),
            self.sendErrorButton.heightAnchor.constraint(equalTo: self.getAppInfoButton.heightAnchor)
        ])
    }

}

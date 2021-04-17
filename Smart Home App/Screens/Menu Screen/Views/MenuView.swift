//
//  MenuView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/17/21.
//

import UIKit

protocol IMenuView: AnyObject {
    var closeButtonTapped: (() -> Void)? { get set }
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
        myButton.tintColor = .black
        myButton.addTarget(self, action: #selector(buttonSelector), for: .touchUpInside)
        return myButton
    }()

    private lazy var tapToCloseView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .clear
        return myView
    }()

    // MARK: - Properties

    var closeButtonTapped: (() -> Void)?
    var moveBackScreenContentBack: (() -> Void)?

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
        self.hideMenu()
    }

    @objc func viewTapped(_ panRecognizer: UIPanGestureRecognizer) {
        self.hideMenu()
    }

    // MARK: - Private

    private func hideMenu() {
        self.moveBackScreenContentBack?()
        UIView.animate(withDuration: AppConstants.AnimationTime.menuAnimationTime) {
            self.backgroundColor = UIColor(white: 1, alpha: 0)
            self.slidingMenuView.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { (bool) in
            self.closeButtonTapped?()
        }
    }

    private func setupTapToClose() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        self.tapToCloseView.addGestureRecognizer(viewTap)
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
}

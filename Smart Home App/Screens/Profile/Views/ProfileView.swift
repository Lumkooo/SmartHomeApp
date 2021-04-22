//
//  ProfileView.swift
//  FocusStartProject
//
//  Created by Андрей Шамин on 12/8/20.
//

import UIKit

protocol IProfileView: class {
    var registerTapped: (()-> Void)? { get set }
    var loginTapped: (()-> Void)? { get set }
    var logoutTapped: (() -> Void)? { get set }

    func setupViewForAuthorizedUser(userEmail: String)
    func setupViewForUnauthorizedUser()
}

final class ProfileView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let animationViewAnimationConstant: CGFloat = 200
        static let animationViewHeight: CGFloat = 130
        static let animationViewEmailButtonSize: CGSize = CGSize(width: 75, height: 75)
        static let animatedButtonCornerRadius: CGFloat = 7
        static let animatedViewBackgroundViewAlpha: CGFloat = 0.25
        static let animationTime: Double = 0.5
    }

    // MARK: - Views

    private let activityIndicator: UIActivityIndicatorView = {
        let myActivityIndicatorView = UIActivityIndicatorView()
        myActivityIndicatorView.hidesWhenStopped = true
        myActivityIndicatorView.startAnimating()
        return myActivityIndicatorView
    }()

    // MARK: - authorizedView

    private lazy var authorizedView: UIView = {
        let myView = UIView()
        return myView
    }()

    private lazy var authorizedTopTitle: UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .natural
        myLabel.numberOfLines = 0
        myLabel.text = Localized("loggedInAs")
        myLabel.font = AppConstants.Fonts.titleLabelFont
        return myLabel
    }()

    private lazy var authorizedRecordsListTitle: UILabel = {
        let myLabel = UILabel()
        myLabel.font = AppConstants.Fonts.titleLabelFont
        myLabel.numberOfLines = 0
        return myLabel
    }()

    private lazy var logoutButton: CustomButton = {
        let myButton = CustomButton()
        myButton.setTitle(Localized("logout"), for: .normal)
        myButton.addTarget(self,
                           action: #selector(logoutButtonTapped(gesture:)),
                           for: .touchUpInside)
        return myButton
    }()

    // MARK: - unauthorizedView

    private lazy var unauthorizedView: UIView = {
        let myView = UIView()
        return myView
    }()

    private lazy var unauthorizedTopLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        myLabel.font = AppConstants.Fonts.titleLabelFont
        myLabel.textAlignment = .center
        myLabel.text = Localized("profile.guestText")
        return myLabel
    }()

    private lazy var registerButton: CustomButton = {
        let myButton = CustomButton()
        myButton.setTitle(Localized("register"), for: .normal)
        myButton.addTarget(self,
                           action: #selector(registerButtonTapped(gesture:)),
                           for: .touchUpInside)
        return myButton
    }()

    private lazy var loginButton: CustomButton = {
        let myButton = CustomButton()
        myButton.setTitle(Localized("loginButtonText"), for: .normal)
        myButton.addTarget(self,
                           action: #selector(loginButtonTapped(gesture:)),
                           for: .touchUpInside)
        return myButton
    }()

    // MARK: - AnimatedView

    private lazy var animatedViewBackgroundView: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.black.withAlphaComponent(0)
        return myView
    }()

    private lazy var animatedView: UIView = {
        let myView = UIView()
        myView.layer.cornerRadius = Constants.animatedButtonCornerRadius
        myView.backgroundColor = .tertiarySystemGroupedBackground
        return myView
    }()

    private lazy var animatedViewTopLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = Localized("with")
        myLabel.textColor = .label
        myLabel.font = AppConstants.Fonts.titleLabelFont
        return myLabel
    }()

    private lazy var animatedViewEmailButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(AppConstants.Images.email, for: .normal)
        return myButton
    }()

    private lazy var closeAnimatedViewButton: CustomCloseButton = {
        let myButton = CustomCloseButton()
        myButton.addTarget(self,
                           action: #selector(closeAnimatedViewButtonTapped(gesture:)),
                           for: .touchUpInside)
        return myButton
    }()

    // MARK: - Properties

    var registerTapped: (()-> Void)?
    var loginTapped: (()-> Void)?
    var logoutTapped: (() -> Void)?
    var cellTapped: ((IndexPath) -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.setupActivityIndicator()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Настройка activityIndicator-а, отображаемого при загрузке экрана

private extension ProfileView {
    func setupActivityIndicator() {
        self.addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

// MARK: - Настройка AthorizedScreen-а (Экрана авторизованного пользователя)

private extension ProfileView {
    func setupAthorizedScreen() {
        self.setupAuthorizedView()
        self.setupAuthorizedTopTitle()
        self.setupAuthorizedRecordsListTitle()
        self.setupLogoutButton()
    }

    func setupAuthorizedView() {
        self.addSubview(self.authorizedView)
        self.authorizedView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.authorizedView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.authorizedView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.authorizedView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.authorizedView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func setupAuthorizedTopTitle() {
        self.authorizedView.addSubview(self.authorizedTopTitle)
        self.authorizedTopTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.authorizedTopTitle.topAnchor.constraint(
                equalTo: self.authorizedView.topAnchor,
                constant: AppConstants.Constraints.quarter),
            self.authorizedTopTitle.leadingAnchor.constraint(
                equalTo: self.authorizedView.leadingAnchor,
                constant: AppConstants.Constraints.normal),
            self.authorizedTopTitle.trailingAnchor.constraint(
                equalTo: self.authorizedView.trailingAnchor,
                constant: -AppConstants.Constraints.normal)
        ])
    }

    func setupAuthorizedRecordsListTitle() {
        self.authorizedView.addSubview(self.authorizedRecordsListTitle)
        self.authorizedRecordsListTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.authorizedRecordsListTitle.topAnchor.constraint(
                equalTo: self.authorizedTopTitle.bottomAnchor,
                constant: AppConstants.Constraints.normal),
            self.authorizedRecordsListTitle.leadingAnchor.constraint(
                equalTo: self.authorizedView.leadingAnchor,
                constant: AppConstants.Constraints.normal),
            self.authorizedRecordsListTitle.trailingAnchor.constraint(
                equalTo: self.authorizedView.trailingAnchor,
                constant: -AppConstants.Constraints.normal)
        ])
    }

    func setupLogoutButton() {
        self.authorizedView.addSubview(self.logoutButton)
        self.logoutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.logoutButton.bottomAnchor.constraint(
                equalTo: self.authorizedView.bottomAnchor,
                constant: -AppConstants.Constraints.normal),
            self.logoutButton.leadingAnchor.constraint(
                equalTo: self.authorizedView.leadingAnchor,
                constant: AppConstants.Constraints.normal),
            self.logoutButton.trailingAnchor.constraint(
                equalTo: self.authorizedView.trailingAnchor,
                constant: -AppConstants.Constraints.normal),
            self.logoutButton.heightAnchor.constraint(equalToConstant: AppConstants.Sizes.closeButtonSize.height)
        ])
    }
}

// MARK: - Обработка нажатий на кнопки authorizedView

private extension ProfileView {
    @objc private func logoutButtonTapped(gesture: UIGestureRecognizer) {
        self.logoutTapped?()
    }
}

// MARK: - Настройка UnathorizedScreen-а (Экрана с кнопками регистрации и авторизации)

private extension ProfileView {
    func setupUnathorizedScreen() {
        self.setupUnathorizedView()
        self.setupLoginButton()
        self.setupSignInButton()
        self.setupUnauthorizedTopLabel()
    }

    func setupUnathorizedView() {
        self.addSubview(self.unauthorizedView)
        self.unauthorizedView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.unauthorizedView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.unauthorizedView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.unauthorizedView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.unauthorizedView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func setupLoginButton() {
        self.unauthorizedView.addSubview(self.loginButton)
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(
                equalTo: self.unauthorizedView.centerYAnchor,
                constant: AppConstants.Constraints.normal),
            self.loginButton.leadingAnchor.constraint(
                equalTo: self.unauthorizedView.leadingAnchor,
                constant: AppConstants.Constraints.normal),
            self.loginButton.trailingAnchor.constraint(
                equalTo: self.unauthorizedView.trailingAnchor,
                constant: -AppConstants.Constraints.normal),
            self.loginButton.heightAnchor.constraint(equalToConstant: AppConstants.Sizes.closeButtonSize.height)
        ])
    }

    func setupSignInButton() {
        self.unauthorizedView.addSubview(self.registerButton)
        self.registerButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.registerButton.bottomAnchor.constraint(
                equalTo: self.unauthorizedView.centerYAnchor,
                constant: -AppConstants.Constraints.normal),
            self.registerButton.leadingAnchor.constraint(
                equalTo: self.unauthorizedView.leadingAnchor,
                constant: AppConstants.Constraints.normal),
            self.registerButton.trailingAnchor.constraint(
                equalTo: self.unauthorizedView.trailingAnchor,
                constant: -AppConstants.Constraints.normal),
            self.registerButton.heightAnchor.constraint(equalToConstant: AppConstants.Sizes.closeButtonSize.height)
        ])
    }

    func setupUnauthorizedTopLabel() {
        self.addSubview(self.unauthorizedTopLabel)
        self.unauthorizedTopLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.unauthorizedTopLabel.topAnchor.constraint(
                equalTo: self.unauthorizedView.topAnchor,
                constant: AppConstants.Constraints.twice),
            self.unauthorizedTopLabel.leadingAnchor.constraint(
                equalTo: self.unauthorizedView.leadingAnchor,
                constant: AppConstants.Constraints.normal),
            self.unauthorizedTopLabel.trailingAnchor.constraint(
                equalTo: self.unauthorizedView.trailingAnchor,
                constant: -AppConstants.Constraints.normal)
        ])
    }
}

// MARK: - Обработка нажатий на кнопки unauthorizedView

private extension ProfileView {
    @objc private func registerButtonTapped(gesture: UIGestureRecognizer) {
        self.showAnimatedRegisterView(withActionForButton: #selector(registerWithEmail(gesture:)))
    }

    @objc private func loginButtonTapped(gesture: UIGestureRecognizer) {
        self.showAnimatedRegisterView(withActionForButton: #selector(loginWithEmail(gesture:)))
    }
}

// MARK: - IProfileView

extension ProfileView: IProfileView {
    func setupViewForAuthorizedUser(userEmail: String) {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.setupAthorizedScreen()
        self.authorizedTopTitle.text = Localized("loggedInAs")+": \(userEmail)"
    }

    func setupViewForUnauthorizedUser() {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.setupUnathorizedScreen()
    }
}

// MARK: - Настройка AnimatedRegisterView

private extension ProfileView {

    @objc func closeAnimatedViewButtonTapped(gesture: UIGestureRecognizer) {
        self.closeAnimatedRegisterView()
    }

    func closeAnimatedRegisterView() {
        UIView.animate(withDuration: Constants.animationTime) {
            self.animatedView.transform = CGAffineTransform(translationX: 0,
                                                            y: Constants.animationViewAnimationConstant)
            self.animatedViewBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0)
        } completion: { (bool) in
            self.animatedViewBackgroundView.removeFromSuperview()
        }
    }

    func showAnimatedRegisterView(withActionForButton action: Selector) {
        self.animatedViewEmailButton.removeTarget(self, action: nil, for: .touchUpInside)
        self.animatedViewEmailButton.addTarget(self, action: action, for: .touchUpInside)
        self.setupAnimatedViewBackgroundView()
        self.setupAnimatedView()
        UIView.animate(withDuration: Constants.animationTime) {
            self.animatedView.transform = CGAffineTransform(translationX: 0,
                                                            y: -Constants.animationViewAnimationConstant)

            self.animatedViewBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(Constants.animatedViewBackgroundViewAlpha)
        }
    }

    func setupAnimatedViewBackgroundView() {
        self.addSubview(self.animatedViewBackgroundView)
        self.animatedViewBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.animatedViewBackgroundView.leadingAnchor.constraint(equalTo:
                                                                        self.safeAreaLayoutGuide.leadingAnchor),
            self.animatedViewBackgroundView.trailingAnchor.constraint(equalTo:
                                                                        self.safeAreaLayoutGuide.trailingAnchor),
            self.animatedViewBackgroundView.bottomAnchor.constraint(equalTo:
                                                                        self.safeAreaLayoutGuide.bottomAnchor),
            self.animatedViewBackgroundView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
    }

    func setupAnimatedView() {
        self.animatedViewBackgroundView.addSubview(self.animatedView)
        self.animatedView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.animatedView.leadingAnchor.constraint(equalTo: self.animatedViewBackgroundView.leadingAnchor),
            self.animatedView.trailingAnchor.constraint(equalTo: self.animatedViewBackgroundView.trailingAnchor),
            self.animatedView.bottomAnchor.constraint(equalTo: self.animatedViewBackgroundView.bottomAnchor,
                                                      constant: Constants.animationViewAnimationConstant),
            self.animatedView.heightAnchor.constraint(equalToConstant: Constants.animationViewHeight)
        ])

        self.setupAnimatedViewTopLabel()
        self.setupAnimatedViewEmailButton()
        self.setupCloseAnimatedViewButton()
    }

    func setupAnimatedViewTopLabel() {
        self.animatedView.addSubview(self.animatedViewTopLabel)
        self.animatedViewTopLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.animatedViewTopLabel.centerXAnchor.constraint(equalTo: self.animatedView.centerXAnchor),
            self.animatedViewTopLabel.topAnchor.constraint(
                equalTo: self.animatedView.topAnchor,
                constant: AppConstants.Constraints.normal)
        ])
    }

    func setupAnimatedViewEmailButton() {
        self.animatedView.addSubview(self.animatedViewEmailButton)
        self.animatedViewEmailButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.animatedViewEmailButton.centerXAnchor.constraint(equalTo: self.animatedView.centerXAnchor),
            self.animatedViewEmailButton.bottomAnchor.constraint(
                equalTo: self.animatedView.bottomAnchor,
                constant: -AppConstants.Constraints.normal),
            self.animatedViewEmailButton.heightAnchor.constraint(equalToConstant: Constants.animationViewEmailButtonSize.height),
            self.animatedViewEmailButton.widthAnchor.constraint(equalToConstant: Constants.animationViewEmailButtonSize.width)
        ])
    }

    func setupCloseAnimatedViewButton() {
        self.animatedView.addSubview(self.closeAnimatedViewButton)
        self.closeAnimatedViewButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.closeAnimatedViewButton.trailingAnchor.constraint(
                equalTo: self.animatedView.trailingAnchor,
                constant: -AppConstants.Constraints.normal),
            self.closeAnimatedViewButton.topAnchor.constraint(
                equalTo: self.animatedView.topAnchor,
                constant: AppConstants.Constraints.normal),
            self.closeAnimatedViewButton.heightAnchor.constraint(
                equalToConstant: AppConstants.Sizes.smallCloseButtonSize.height),
            self.closeAnimatedViewButton.widthAnchor.constraint(
                equalToConstant: AppConstants.Sizes.smallCloseButtonSize.width)
        ])
    }
}

// MARK: - Обработка нажатий на кнопки animatedView

private extension ProfileView {
    @objc private func registerWithEmail(gesture: UIGestureRecognizer) {
        self.closeAnimatedRegisterView()
        self.registerTapped?()
    }

    @objc private func loginWithEmail(gesture: UIGestureRecognizer) {
        self.closeAnimatedRegisterView()
        self.loginTapped?()
    }
}

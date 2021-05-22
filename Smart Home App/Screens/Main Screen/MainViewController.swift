//
//  ViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/20/21.
//

import UIKit

protocol IMenuDelegate {
    func moveContentBackAfterMenu()
    func goToAppInfo()
    func goToSendError()
}

class MainViewController: UIViewController {

    // MARK: - Properties

    private let presenter: IMainPresenter
    private let ui = MainView()

    // MARK: - Init

    init(presenter: IMainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.title = Localized("deviceList")
        self.view = self.ui
        self.setupMenuButton()
        self.setupAddButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear(ui: self.ui)
    }

    private func setupMenuButton() {
        let image = AppConstants.Images.menuImage
//        image = image.withRenderingMode(.alwaysOriginal)
        let menu = UIBarButtonItem(image: image,
                                   style:.plain,
                                   target: self,
                                   action: #selector(menuTapped))
        menu.accessibilityIdentifier = "MenuButtonIdentifier"
        menu.tintColor = .label
        self.navigationItem.setRightBarButton(menu, animated: true)
    }

    @objc private func menuTapped() {
        self.presenter.goToMenu(delegate: self)
        UIView.animate(withDuration: AppConstants.AnimationTime.menuAnimationTime) {
            self.navigationController?.navigationBar.transform = CGAffineTransform(
                translationX: -self.view.frame.width * AppConstants.Sizes.menuWidth,
                y: 0)
        }
    }

    private func setupAddButton() {
        let add = UIBarButtonItem(barButtonSystemItem: .add,
                                  target: self,
                                  action: #selector(addTapped))
        add.tintColor = .label
        add.accessibilityIdentifier = "AddButtonIdentifier"
        self.navigationItem.setLeftBarButton(add, animated: true)
    }

    @objc private func addTapped() {
        self.presenter.addDeviceTapped()
    }
}

extension MainViewController: IMenuDelegate {
    func moveContentBackAfterMenu() {
        self.presenter.moveContentBackAfterMenu()
        UIView.animate(withDuration: AppConstants.AnimationTime.menuAnimationTime) {
            self.navigationController?.navigationBar.transform = CGAffineTransform(
                translationX: 0,
                y: 0)
        }
    }

    func goToAppInfo() {
        self.presenter.goToAppInfo()
    }

    func goToSendError() {
        self.presenter.goToSendError()
    }
}


extension MainViewController: IProfileDelegate {
    func userSignIn() {
        self.presenter.userSignIn()
    }

    func userSignOut() {
        self.presenter.userSignOut()
    }
}

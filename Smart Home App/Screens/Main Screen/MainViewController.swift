//
//  ViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/20/21.
//

import UIKit

protocol IMenuDelegate {
    func moveContentBackAfterMenu()
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
        var image = AppConstants.Images.menuImage
        image = image.withRenderingMode(.alwaysOriginal)
        let menu = UIBarButtonItem(image: image,
                                   style:.plain,
                                   target: self,
                                   action: #selector(menuTapped))
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
}

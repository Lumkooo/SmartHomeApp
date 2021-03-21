//
//  ViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/20/21.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties

    private let presenter: IMainPresenter
    private let ui = MainView()

    // MARK: - Init

    init(presenter: IMainPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC Life cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view = self.ui
        self.presenter.viewDidLoad(ui: ui)
    }
}


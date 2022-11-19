//
//  AppInfoViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import UIKit

final class AppInfoViewController: UIViewController {

    // MARK: - Properties

    private let appInfoView = AppInfoView()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //  MARK: - VC life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.appInfoView
    }
}

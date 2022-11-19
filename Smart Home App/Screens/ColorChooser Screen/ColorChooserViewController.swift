//
//  ColorChooserViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import UIKit

final class ColorChooserViewController: UIViewController {

    // MARK: - Properties

    private let presenter: IColorChooserPresenter
    private let ui = ColorChooserView()

    // MARK: - Init

    init(presenter: IColorChooserPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.ui
        self.presenter.viewDidLoad(ui: self.ui)
    }
}

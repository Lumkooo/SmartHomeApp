//
//  EditableDeviceViewController.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/28/21.
//

import UIKit

class EditableDeviceViewController: UIViewController {

    // MARK: - Properties

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func setupNavigationBarRightButton(actions: [UIAction]) {
        var image = AppConstants.Images.ellipsis
        image = image?.withRenderingMode(.alwaysTemplate)
        image = image?.withTintColor(.label)
        var childrens: [UIAction] = []
        for action in actions {
            childrens.append(action)
        }

        let menuBarButton = UIBarButtonItem(
            title: Localized("menu"),
            image: image,
            primaryAction: nil,
            menu: UIMenu(title: "", children: childrens)
        )

        self.navigationItem.setRightBarButton(menuBarButton, animated: false)
    }
}

//
//  ColorChooserPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import UIKit

protocol IColorChooserPresenter {
    func viewDidLoad(ui: IColorChooserView)
}

final class ColorChooserPresenter {

    // MARK: - Proeprties

    private weak var ui: IColorChooserView?
    private let interactor: IColorChooserInteractor
    private let router: IColorChooserRouter

    // MARK: - Init

    init(interactor: IColorChooserInteractor, router: IColorChooserRouter) {
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - IColorChooserPresenter

extension ColorChooserPresenter: IColorChooserPresenter {
    func viewDidLoad(ui: IColorChooserView) {
        self.ui = ui
        self.ui?.cellTappedAt = { [weak self] indexPath in
            self?.interactor.cellTappedAt(indexPath)
        }
        self.ui?.dismissView = { [weak self] in
            self?.dismissVC()
        }
        self.interactor.loadInitData()
    }
}

extension ColorChooserPresenter: IColorChooserInteractorOuter {
    func setupView(colors: [UIColor]) {
        self.ui?.setupView(colors: colors)
    }

    func dismissVC() {
        self.ui?.prepareViewToClose {
            self.router.dismissVC()
        }
    }
}

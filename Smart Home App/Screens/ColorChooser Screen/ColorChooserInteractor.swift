//
//  ColorChooserInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import UIKit

protocol IColorChooserInteractor {
    func loadInitData()
    func cellTappedAt(_ indexPath: IndexPath)
}

protocol IColorChooserInteractorOuter: AnyObject {
    func setupView(colors: [UIColor])
    func dismissVC()
}

protocol ColorChooserDelegate {
    func colorDidChangeTo(_ color: UIColor)
}

final class ColorChooserInteractor {

    // MARK: - Proeprties

    weak var presenter: IColorChooserInteractorOuter?
    private let delegate: ColorChooserDelegate
    private let colors: [UIColor] = [.red, .white, .gray, .blue]

    // MARK: - Init

    init(delegate: ColorChooserDelegate) {
        self.delegate = delegate
    }
}

// MARK: - IColorChooserInteractor

extension ColorChooserInteractor: IColorChooserInteractor {
    func loadInitData() {
        self.presenter?.setupView(colors: self.colors)
    }

    func cellTappedAt(_ indexPath: IndexPath) {
        let index = indexPath.row
        if self.colors.count > index {
            let color = self.colors[index]
            self.delegate.colorDidChangeTo(color)
            print("color is: ", color)
            self.presenter?.dismissVC()
        }
    }
}

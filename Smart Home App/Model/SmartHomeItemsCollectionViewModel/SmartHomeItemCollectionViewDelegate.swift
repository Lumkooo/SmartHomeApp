//
//  SmartHomeItemCollectionViewDelegate.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

protocol IImagesCollectionViewDelegate: class {
    func goToDevice(atIndexPath indexPath: IndexPath)
}

final class SmartHomeItemCollectionViewDelegate: NSObject {

    // MARK: - Properties

    private weak var delegate: (IImagesCollectionViewDelegate & ICustomCollectionViewDelegate)?

    // MARK: - Init

    init(withDelegate delegate: (IImagesCollectionViewDelegate & ICustomCollectionViewDelegate)) {
        self.delegate = delegate
    }
}

// MARK: - UICollectionViewDelegate

extension SmartHomeItemCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectItemAt(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, previewProvider: nil) { _ in

            let addToLiked = UIAction(title: Localized("addToLiked"),
                                image: AppConstants.Images.heartFill) { action in
                // TODO: - Добавление в избранные
            }

            let goToDevice = UIAction(title: Localized("goToDevice"),
                                image: AppConstants.Images.arrowRight) { action in
                // TODO: - Переход к девайсу
                self.delegate?.goToDevice(atIndexPath: indexPath)
            }


            return UIMenu(title: "", children: [goToDevice, addToLiked])
        }
    }
}


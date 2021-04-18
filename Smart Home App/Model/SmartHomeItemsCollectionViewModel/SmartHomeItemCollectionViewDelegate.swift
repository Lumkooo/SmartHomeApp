//
//  SmartHomeItemCollectionViewDelegate.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

protocol IImagesCollectionViewDelegate: class {
    func toggleLikedState(atIndexPath indexPath: IndexPath)
    func goToDevice(atIndexPath indexPath: IndexPath)
}

final class SmartHomeItemCollectionViewDelegate: NSObject {
    
    // MARK: - Properties
    
    private weak var delegate: (IImagesCollectionViewDelegate & ICustomCollectionViewDelegate)?
    private var devices: [SmartHomeDevice] = []
    
    // MARK: - Init
    
    init(withDelegate delegate: (IImagesCollectionViewDelegate & ICustomCollectionViewDelegate)) {
        self.delegate = delegate
    }
    
    // MARK: - Public
    
    func setData(devices: [SmartHomeDevice]) {
        self.devices = devices
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
        if self.devices[indexPath.item].isLoved {
            return UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, previewProvider: nil) { _ in
                
                let addToLiked = UIAction(title: Localized("removeFromLiked"),
                                          image: AppConstants.Images.heartSlashFill) { action in
                    // MARK: - Добавление в избранные
                    self.delegate?.toggleLikedState(atIndexPath: indexPath)
                }
                let goToDevice = UIAction(title: Localized("goToDevice"),
                                          image: AppConstants.Images.arrowRight) { action in
                    // MARK: - Переход к девайсу
                    self.delegate?.goToDevice(atIndexPath: indexPath)
                }
                
                
                return UIMenu(title: "", children: [goToDevice, addToLiked])
            }
        } else {
            return UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, previewProvider: nil) { _ in
                
                let addToLiked = UIAction(title: Localized("addToLiked"),
                                          image: AppConstants.Images.heartFill) { action in
                    // MARK: - Добавление в избранные
                    self.delegate?.toggleLikedState(atIndexPath: indexPath)
                }
                let goToDevice = UIAction(title: Localized("goToDevice"),
                                          image: AppConstants.Images.arrowRight) { action in
                    // MARK: - Переход к девайсу
                    self.delegate?.goToDevice(atIndexPath: indexPath)
                }
                
                
                return UIMenu(title: "", children: [goToDevice, addToLiked])
            }
        }
    }
}


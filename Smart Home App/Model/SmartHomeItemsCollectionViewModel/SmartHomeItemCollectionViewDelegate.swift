//
//  SmartHomeItemCollectionViewDelegate.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

protocol IImagesCollectionViewDelegate: class {
    func selectedCell(indexPath: IndexPath)
}

final class SmartHomeItemCollectionViewDelegate: NSObject {

    // MARK: - Properties

    private weak var delegate: IImagesCollectionViewDelegate?

    // MARK: - Init

    init(withDelegate delegate: IImagesCollectionViewDelegate) {
        self.delegate = delegate
    }
}

// MARK: - UICollectionViewDelegate

extension SmartHomeItemCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath: indexPath)
    }
}


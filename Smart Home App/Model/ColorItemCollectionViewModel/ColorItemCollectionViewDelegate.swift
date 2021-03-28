//
//  ColorItemCollectionViewDelegate.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import UIKit

final class ColorItemCollectionViewDelegate: NSObject {

    // MARK: - Properties

    private weak var delegate: ICustomCollectionViewDelegate?

    // MARK: - Init

    init(withDelegate delegate: ICustomCollectionViewDelegate) {
        self.delegate = delegate
    }
}

// MARK: - UICollectionViewDelegate

extension ColorItemCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectItemAt(indexPath: indexPath)
    }
}


//
//  ColorItemCollectionViewDataSource.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import UIKit

final class ColorItemCollectionViewDataSource: NSObject {

    // MARK: Properties

    private(set) var colors: [UIColor] = []

    // MARK: - Методы для работы с modelArray

    func setData(colors: [UIColor]) {
        self.colors = colors
    }
}

// MARK: UICollectionViewDataSource

extension ColorItemCollectionViewDataSource: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.colors.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ColorItemCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ColorItemCollectionViewCell
        else {
            fatalError("Can't dequeue reusable cell")
        }
        let color = self.colors[indexPath.row]
        cell.setupCell(color: color)
        return cell
    }
}

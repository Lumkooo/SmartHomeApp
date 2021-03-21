//
//  SmartHomeItemCollectionViewDataSource.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

final class SmartHomeItemCollectionViewDataSource: NSObject {

    // MARK: Properties

    private(set) var devices: [SmartHomeDevice] = []

    // MARK: - Методы для работы с modelArray

    func setData(devices: [SmartHomeDevice]) {
        self.devices = devices
    }

    func removeAt(indexPath: IndexPath) {
        if self.devices.count > indexPath.row {
            self.devices.remove(at: indexPath.row)
        }
    }
}

// MARK: UICollectionViewDataSource

extension SmartHomeItemCollectionViewDataSource: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.devices.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SmartHomeItemCollectionViewCell.reuseIdentifier,
                for: indexPath) as? SmartHomeItemCollectionViewCell
        else {
            fatalError("Can't dequeue reusable cell")
        }
        let device = self.devices[indexPath.row]
        cell.setupCell(device: device)
        return cell
    }
}

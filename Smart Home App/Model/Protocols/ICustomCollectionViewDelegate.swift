//
//  ICustomCollectionViewDelegate.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import Foundation

protocol ICustomCollectionViewDelegate: class {
    func didSelectItemAt(indexPath: IndexPath)
}

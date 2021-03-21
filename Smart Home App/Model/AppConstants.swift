//
//  AppConstants.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

enum AppConstants {

    // MARK: - Constraints

    enum Constraints {
        static let normal: CGFloat = 16.0
        static let half: CGFloat = 8.0
        static let quarter: CGFloat = 4.0
        static let twice: CGFloat = 32.0
    }

    // MARK: - Sizes

    enum Sizes {
        static let cornerRadius: CGFloat = 15
        static let borderWidth: CGFloat = 5
        static let shadowRadius: CGFloat = 6
        static let shadowOpacity: Float = 1
    }

    // MARK: - Images

    enum Images {
        static let lamp = UIImage(systemName: "lightbulb.fill") ?? UIImage()
        static let electricalSocket = UIImage(systemName: "person.fill") ?? UIImage()
    }
}

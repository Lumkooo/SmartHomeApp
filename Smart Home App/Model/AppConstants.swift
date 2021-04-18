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
        static let customSliderWidthMultiplier: CGFloat = 0.35
        static let menuWidth: CGFloat = 0.8
        static let closeButtonSize: CGSize = CGSize(width: 50, height: 50)
    }

    // MARK: - Images

    enum Images {
        static let mainTabImage = UIImage(systemName: "list.bullet")
        static let profileTabImage = UIImage(systemName: "person")
        static let profileTabFilledImage = UIImage(systemName: "person.fill")
        static let heart = UIImage(systemName: "heart") ?? UIImage()
        static let heartFill = UIImage(systemName: "heart.fill") ?? UIImage()

        static let lamp = UIImage(named: "lamp") ?? UIImage()
        static let electricalSocket = UIImage(named: "electricalSocket") ?? UIImage()
        static let airConditioner = UIImage(named: "airConditioner") ?? UIImage()
        static let curtains = UIImage(named: "curtains") ?? UIImage()
        static let ventilator = UIImage(named: "ventilator") ?? UIImage()
        static let garageDoor = UIImage(named: "garageDoor") ?? UIImage()
        static let irrigationSystem = UIImage(named: "irrigationSystem") ?? UIImage()
        static let arrowRight = UIImage(systemName: "arrow.right") ?? UIImage()
        static let power = UIImage(systemName: "power") ?? UIImage()
        static let circleFill = UIImage(systemName: "circle.fill") ?? UIImage()
        static let xmark = UIImage(systemName: "xmark") ?? UIImage()
        static let menuImage = UIImage(named: "menu_image") ?? UIImage()
        static let heartSlashFill = UIImage(systemName: "heart.slash.fill") ?? UIImage()
    }

    // MARK: - Fonts

    enum Fonts {
        static let deviceLabel = UIFont.systemFont(ofSize: 15)
        static let deviceSmallLabel = UIFont.systemFont(ofSize: 13)
    }

    // MARK: - Animation time

    enum AnimationTime {
        static let menuAnimationTime: Double = 0.5
    }
}

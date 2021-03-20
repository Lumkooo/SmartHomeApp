//
//  TabBarControllerAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/20/21.
//

import UIKit

enum TabBarControllerAssembly {
    static func createTabBar() -> UITabBarController {

        // MARK: - Images

        enum Images {
            static let mapTabImage = UIImage(systemName: "map")
            static let mapTabFilledImage = UIImage(systemName: "map.fill")
            static let mainTabImage = UIImage(systemName: "list.bullet")
            static let profileTabImage = UIImage(systemName: "person")
            static let profileTabFilledImage = UIImage(systemName: "person.fill")
            static let bagTabImage = UIImage(systemName: "bag")
            static let bagTabFilledImage = UIImage(systemName: "bag.fill")
        }


        let tabBar = UITabBarController()

        // MARK: - MainScreen

        let mainViewController =  MainScreenAssembly.createVC()
        let mainTab = NavigationControllerAssembly.createNavigationVC(for: mainViewController)
        let mainTabItem = UITabBarItem(title: "Главная",
                                         image: Images.bagTabImage,
                                         selectedImage: Images.bagTabFilledImage)
        mainTab.tabBarItem = mainTabItem

        let controllers = [mainTab]
        tabBar.viewControllers = controllers

        return tabBar
    }
}

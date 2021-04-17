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
            static let mainTabImage = UIImage(systemName: "list.bullet")
            static let profileTabImage = UIImage(systemName: "person")
            static let profileTabFilledImage = UIImage(systemName: "person.fill")
        }


        let tabBar = UITabBarController()

        // MARK: - MainScreen

        let mainViewController =  MainScreenAssembly.createVC()
        let mainTab = NavigationControllerAssembly.createNavigationVC(for: mainViewController)
        let mainTabItem = UITabBarItem(title: Localized("general"),
                                         image: Images.mainTabImage,
                                         selectedImage: Images.mainTabImage)
        mainTab.tabBarItem = mainTabItem
        mainTab.navigationItem.largeTitleDisplayMode = .always

        // MARK: - MainScreen

        let profileViewController =  ProfileVCAssembly.createVC()
        let profileTab = NavigationControllerAssembly.createNavigationVC(for: profileViewController)
        let profileTabItem = UITabBarItem(title: Localized("profile"),
                                         image: Images.profileTabImage,
                                         selectedImage: Images.profileTabFilledImage)
        profileTab.tabBarItem = profileTabItem

        let controllers = [mainTab, profileTab]
        tabBar.viewControllers = controllers

        return tabBar
    }
}

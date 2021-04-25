//
//  TabBarControllerAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/20/21.
//

import UIKit

enum TabBarControllerAssembly {
    static func createTabBar() -> UITabBarController {

        let tabBar = UITabBarController()

        // MARK: - Loved Devices Screen

        let lovedDevicesViewController =  LovedDevicesAssembly.createVC()
        let lovedDevicesTab = NavigationControllerAssembly.createNavigationVC(for: lovedDevicesViewController)
        let lovedDevicesTabItem = UITabBarItem(title: Localized("loved"),
                                               image: AppConstants.Images.heart,
                                               selectedImage: AppConstants.Images.heartFill)
        lovedDevicesTab.tabBarItem = lovedDevicesTabItem
        lovedDevicesTab.navigationItem.largeTitleDisplayMode = .always

        // MARK: - Main Screen

        let mainViewController =  MainScreenAssembly.createVC(lovedDevicesDelegate: lovedDevicesViewController)
        let mainTab = NavigationControllerAssembly.createNavigationVC(for: mainViewController)
        let mainTabItem = UITabBarItem(title: Localized("general"),
                                       image: AppConstants.Images.mainTabImage,
                                       selectedImage: AppConstants.Images.mainTabImage)
        mainTab.tabBarItem = mainTabItem
        mainTab.navigationItem.largeTitleDisplayMode = .always


        // MARK: - Profile Screen

        let profileViewController =  ProfileVCAssembly.createVC(profileDelegate: mainViewController)
        let profileTab = NavigationControllerAssembly.createNavigationVC(for: profileViewController)
        let profileTabItem = UITabBarItem(title: Localized("profile"),
                                          image: AppConstants.Images.profileTabImage,
                                          selectedImage: AppConstants.Images.profileTabFilledImage)
        profileTab.tabBarItem = profileTabItem

        let controllers = [mainTab, lovedDevicesTab, profileTab]
        tabBar.viewControllers = controllers

        return tabBar
    }
}

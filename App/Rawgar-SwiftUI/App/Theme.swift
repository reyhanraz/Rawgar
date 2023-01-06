//
//  Theme.swift
//  Rawgar-SwiftUI
//
//  Created by Reyhan Rifqi on 16/11/22.
//

import SwiftUI

class Theme {
  static func navigationBarColors(background: UIColor? = UIColor(Color.CustomWhite),
                                  titleColor: UIColor? = UIColor(Color.CustomDarkPurple), tintColor: UIColor? = UIColor(Color.CustomDarkPurple) ) {
    
    let navigationAppearance = UINavigationBarAppearance()
    navigationAppearance.configureWithOpaqueBackground()
    navigationAppearance.backgroundColor = background ?? .clear
    
    navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
    navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
    
    UINavigationBar.appearance().standardAppearance = navigationAppearance
    UINavigationBar.appearance().compactAppearance = navigationAppearance
    
    UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    
    let tabBarAppearance = UITabBarAppearance()
    tabBarAppearance.configureWithOpaqueBackground()
    tabBarAppearance.backgroundColor = background ?? .clear
    UITabBar.appearance().tintColor = tintColor
    
    UITabBar.appearance().standardAppearance = tabBarAppearance
    if #available(iOS 15.0, *) {
      UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
    }
    
  }
}

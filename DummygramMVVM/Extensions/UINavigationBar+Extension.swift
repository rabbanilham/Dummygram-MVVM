//
//  UINavigationBar+Extension.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 07/08/22.
//

import UIKit

extension UINavigationBar {
    func useDGLargeTitle() {
        self.prefersLargeTitles = true
        self.titleTextAttributes = [
            .font : UIFont(name: "CircularStd-Bold", size: 18)!,
        ]
        self.largeTitleTextAttributes = [
            .font : UIFont(name: "CircularStd-Bold", size: 32)!,
        ]
        self.tintColor = .label
    }
    
    func useDGTitle() {
        self.titleTextAttributes = [
            .font : UIFont(name: "CircularStd-Bold", size: 18)!
        ]
        self.tintColor = .label
    }
}

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
            .foregroundColor : UIColor.black,
            .font : UIFont(name: "CircularStd-Bold", size: 18)!
        ]
        self.largeTitleTextAttributes = [
            .foregroundColor : UIColor.black,
            .font : UIFont(name: "CircularStd-Bold", size: 32)!,
        ]
        self.tintColor = .black
    }
    
    func useDGTitle() {
        self.titleTextAttributes = [
            .foregroundColor : UIColor.black,
            .font : UIFont(name: "CircularStd-Bold", size: 18)!
        ]
        self.tintColor = .black
    }
}

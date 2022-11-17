//
//  InfoAssembly.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 25.10.2022.
//

import UIKit

enum InfoAssembly {
    
    static func build() -> UIViewController {
        
        let presenter = InfoPresenter()
        let controller = InfoViewController(presenter: presenter)
        
        return controller
    }
}

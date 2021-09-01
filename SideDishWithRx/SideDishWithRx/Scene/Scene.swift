//
//  Scene.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import UIKit

enum Scene {
    case main(MainViewModel)
    case detail(DetailViewModel)
}

extension Scene {
    func instantiate() -> UIViewController {
        switch self {
        case .main(let mainViewModel):
            var mainVC = MainViewController()
            let nav = UINavigationController(rootViewController: mainVC)
            nav.navigationBar.backgroundColor = .white
            mainVC.bind(viewModel: mainViewModel)
            return nav
        case .detail(let detailViewModel):
            var detailVC = DetailViewController()
            
            detailVC.bind(viewModel: detailViewModel)
            
            return detailVC
        }
    }
}

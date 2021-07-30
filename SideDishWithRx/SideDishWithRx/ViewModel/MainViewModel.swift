//
//  MainViewModel.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MainViewModel: CommonViewModel {
    var mainDishList: [Dish]?
    var soupList : [Dish]?
    var sideDishLish: [Dish]?
    
    func detailAction() -> Action<Dish, Void> {
        return Action { dish in
            let detailViewModel = DetailViewModel(sceneCoordinator: self.sceneCoordinator)
            let detailScene = Scene.detail(detailViewModel)
            
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map{ _ in }
        }
    }
}

//
//  CommonViewModel.swift
//  SideDishWithRx
//
//  Created by zeke on 2021/07/29.
//

import Foundation
import RxCocoa
import RxSwift

class CommonViewModel: NSObject {
    let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}

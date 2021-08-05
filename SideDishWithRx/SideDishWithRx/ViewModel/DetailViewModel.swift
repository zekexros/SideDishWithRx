//
//  DetailViewModel.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import Foundation
import RxSwift
import Action

class DetailViewModel: CommonViewModel {

    lazy var popAction: CocoaAction = {
        return CocoaAction { _ in
            return self.sceneCoordinator.close(animation: true).asObservable().map { _ in }
        }
    }()
    
    lazy var transitionAction: Action<Void, Void> = {
        return Action { _ in
            
            return self.sceneCoordinator.close(animation: true).asObservable().map{ _ in }
        }
    }()
    
    func transitionAction2() -> Action<Void, Void> {
            return Action { _ in
                return self.sceneCoordinator.close(animation: true).asObservable().map{ _ in }
            }
        }
}

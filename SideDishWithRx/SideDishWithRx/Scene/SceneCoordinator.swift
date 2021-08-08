//
//  SceneCoordinator.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.first ?? self
    }
}

//화면전환을 담당
class SceneCoordinator: SceneCoordinatorType {
    private var window: UIWindow
    private var currentVC: UIViewController?
    
    required init(window: UIWindow) {
        self.window = window
        self.currentVC = window.rootViewController
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        
        let target = scene.instantiate()
        
        switch style {
        case .push:
            guard let nav = currentVC?.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
            subject.onCompleted()
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            window.makeKeyAndVisible()
            subject.onCompleted()
        }
        
        return subject.ignoreElements().asCompletable()
    }
    
    func close(animation: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let nav = self.currentVC?.navigationController {
                guard nav.popViewController(animated: animation) != nil else {
                    completable(.error(TransitionError.navigationControllerMissing))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last
                
            }
            return Disposables.create()
        }
    }
}

//
//  Rx+AnimationView.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/11/28.
//

import Lottie
import RxSwift

extension Reactive where Base: AnimationView {
    public var state: Binder<Bool> {
        return Binder(self.base) { animationView, bool  in
            if bool {
                animationView.play()
            } else {
                animationView.stop()
            }
        }
    }
}

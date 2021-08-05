//
//  DetailViewController.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/28.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class DetailViewController: UIViewController, ViewModelBindableType {

    var viewModel: DetailViewModel!
    var backBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func bindViewModel() {
        backBarButton.rx.tap
            .do(onNext: { _ in
                print("gkgkgk")
            })
            .bind(to: viewModel.transitionAction2().inputs)
            .disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController!.navigationBar.topItem!.backBarButtonItem = backBarButton
    }
}

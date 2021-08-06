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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func bindViewModel() {
        var backButton = UIBarButtonItem(title: "뒤로", style: .done, target: nil, action: nil)
        backButton.rx.action = viewModel.popAction
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false

    }
}

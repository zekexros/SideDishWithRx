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
import SnapKit

class DetailViewController: UIViewController, ViewModelBindableType {

    var viewModel: DetailViewModel!
    
    let detailScrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    let imagesScrollView: UIScrollView = {
        var scrollView = UIScrollView()
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailScrollView)
        configureAutoLayout()
    }
    
    func bindViewModel() {
        var backButton = UIBarButtonItem(title: "뒤로", style: .done, target: nil, action: nil)
        backButton.rx.action = viewModel.popAction
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
        
        viewModel.fetchDetailDish()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
    }
}

extension DetailViewController {
    func configureAutoLayout() {
        detailScrollView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
    }
}

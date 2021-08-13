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
    
    let detailScrollView = DetailScrollView()
    
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
        
        Observable<String>.just(viewModel.dish.title)
            .asDriver(onErrorJustReturn: "")
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.fetchImages()
            .observe(on: MainScheduler.instance)
            .map { UIImage(data: $0) }
            .map { image -> UIImageView in
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                return imageView
            }
            .enumerated()
            .do { [unowned self] (index, imageView) in
                let xPosition = self.view.frame.width * CGFloat(index)
                let bounds = self.detailScrollView.imagesScrollView.bounds
                imageView.frame = CGRect(x: xPosition, y: 0, width: bounds.width, height: bounds.height)
                self.detailScrollView.imagesScrollView.contentSize.width = self.view.frame.width * CGFloat(index+1)
                self.detailScrollView.configureImagesScrollView(view: imageView)
            }
            .subscribe()
            .disposed(by: rx.disposeBag)
            
        detailScrollView.setUpDishInformationStackView(title: viewModel.dish.title, description: viewModel.dish.description, nPrice: viewModel.dish.nPrice, sPrice: viewModel.dish.sPrice, badge: viewModel.dish.badge)
        
        viewModel.detailDish
            .map { ($0.data.point, $0.data.deliveryInfo, $0.data.deliveryFee) }
            .asDriver(onErrorJustReturn: ("", "", ""))
            .drive { [unowned self] (point, deliveryInfo, deliveryFee) in
                self.detailScrollView.configureDetailInformationStackView(point: point, info: deliveryInfo, fee: deliveryFee)
            }
            .disposed(by: rx.disposeBag)
        
        viewModel.quantity
            .asDriver()
            .map { String($0) }
            .drive(detailScrollView.quantityStackView.quantityLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        detailScrollView.quantityStackView.upButton.rx.tap
            .map { [unowned self] _ in
                self.viewModel.quantity.value + 1
            }
            .bind(to: viewModel.quantity)
            .disposed(by: rx.disposeBag)
        
        detailScrollView.quantityStackView.downButton.rx.tap
            .map { [unowned self] _ -> Int in
                let value = self.viewModel.quantity.value - 1
                return value < 1 ? 1 : value
            }
            .bind(to: viewModel.quantity)
            .disposed(by: rx.disposeBag)
        
        viewModel.detailDish
            .map { $0.data.prices[0] }
            .asDriver(onErrorJustReturn: "")
            .drive(detailScrollView.priceLabel.rx.text)
            .disposed(by: rx.disposeBag)
            
        viewModel.fetchDetailImages()
            .observe(on: MainScheduler.instance)
            .map { UIImage(data: $0) }
            .map { image -> UIImageView in
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                return imageView
            }
            .bind(onNext: { imageView in
                self.detailScrollView.detailSectionStackView.addArrangedSubview(imageView)
            })
            .disposed(by: rx.disposeBag)
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

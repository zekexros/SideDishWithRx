//
//  ViewController.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/07/26.
//

import UIKit

import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources
import SnapKit
import Lottie

final class MainViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MainViewModel!
    
    private lazy var mainDishListTableView: UITableView = { [unowned self] in
        let tableView = UITableView()
        tableView.register(DishTableViewCell.self, forCellReuseIdentifier: DishTableViewCell.cellID)
        self.view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { [unowned self] (dataSource, tableView, indexPath, item) -> UITableViewCell in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishTableViewCell", for: indexPath) as? DishTableViewCell else { return UITableViewCell() }
        
        viewModel.output.isLoading
            .share()
            .bind(to: cell.indicatorView.rx.isAnimating)
            .disposed(by: rx.disposeBag)
        
        Observable.just(item.image)
            .compactMap { URL(string: $0) }
            .flatMap { loadImage(url: $0) }
            .bind(to: cell.dishPhotography.rx.image)
            .disposed(by: rx.disposeBag)

        cell.configureCell(title: item.title, description: item.description, nprice: item.nPrice, sPrice: item.sPrice, badge: item.badge)

        return cell
    })
    
    private func configureDataSource(_ dataSource: RxTableViewSectionedReloadDataSource<SectionOfCustomData>) {
        
        dataSource.titleForHeaderInSection = { dataSource, indexPath in
            return dataSource.sectionModels[indexPath].header
        }
        dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
          return true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAutoLayout()
        configureDataSource(dataSource)
        mainDishListTableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindViewModel() {
        
        // input
        viewModel.input.isViewDidLoad.accept(true)
        
        // output
        viewModel.output.sections
            .asDriver(onErrorJustReturn: [])
            .drive(mainDishListTableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        viewModel.output.error
            .observe(on: MainScheduler.instance)
            .subscribe { [unowned self] event in
                let alertAction = UIAlertAction(title: event.element, style: .default) { _ in
                    viewModel.input.retryTapped.onNext(())
                }
                let alertController = UIAlertController(title: "경고", message: "에러가 발생하였습니다.", preferredStyle: .alert)
                alertController.addAction(alertAction)
                present(alertController, animated: true, completion: nil)
                
//                self.view.addSubview(self.reconnectView)
//                reconnectView.rx.state.onNext(true)
            }
            .disposed(by: rx.disposeBag)
        
        // transition
        Observable.zip(mainDishListTableView.rx.modelSelected(Dish.self), mainDishListTableView.rx.itemSelected)
            .do(onNext: { [unowned self] (dish, indexPath) in
                self.mainDishListTableView.deselectRow(at: indexPath, animated: true)
            })
            .map { $0.0 }
            .bind(to: viewModel.transitionAction.inputs)
            .disposed(by: rx.disposeBag)
        
        mainDishListTableView.rx.separatorStyle.onNext(.none)
    }
    
    func loadImage(url: URL) -> Observable<UIImage> {
        return viewModel.repository.fetchImage(url: url)
            .compactMap { UIImage(data: $0) }
        
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

//AutoLayout
extension MainViewController {
    private func configureAutoLayout() {
        mainDishListTableView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
    }
}

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

class MainViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MainViewModel!
    lazy var mainDishListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DishTableViewCell.self, forCellReuseIdentifier: "DishTableViewCell")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData> { [unowned self] dataSource, tableView, indexPath, item in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishTableViewCell", for: indexPath) as? DishTableViewCell else { return UITableViewCell() }

        Observable.just(item.image)
            .observe(on: ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
            .map { imageURL -> UIImage? in
                guard let url = URL(string: imageURL) else { return nil }
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                return image
            }
            .catchAndReturn(nil)
            .observe(on: MainScheduler.instance)
            .bind(to: cell.dishPhotography.rx.image)
            .disposed(by: self.rx.disposeBag)

        cell.configureCell(title: item.title, description: item.description, nprice: item.nPrice, sPrice: item.sPrice, badge: item.badge)
        
        return cell
    }
    
    func configureDataSource(_ dataSource: RxTableViewSectionedReloadDataSource<SectionOfCustomData>) {
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
        viewModel.fetchDishes()
        configureDataSource(dataSource)
        mainDishListTableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func bindViewModel() {
        viewModel.sections
            .asDriver(onErrorJustReturn: [])
            .debug()
            .drive(mainDishListTableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        mainDishListTableView.rx
            .modelSelected(Dish.self)
            .bind(to: viewModel.transitionAction.inputs)
            .disposed(by: rx.disposeBag)
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
    func configureAutoLayout() {
        mainDishListTableView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
        }
    }
}

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
        configureDataSource(viewModel.dataSource)
        mainDishListTableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        viewModel.sections
            .asDriver(onErrorJustReturn: [])
            .drive(mainDishListTableView.rx.items(dataSource: viewModel.dataSource))
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

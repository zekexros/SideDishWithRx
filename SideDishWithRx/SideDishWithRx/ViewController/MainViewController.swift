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
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel.sections
            .asDriver(onErrorJustReturn: [])
            .drive(mainDishListTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
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

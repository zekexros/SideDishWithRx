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
    var mainDishListTabelView = UITableView()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        cell.textLabel?.text = item.description
        return cell
    }
    
    let sections = [SectionOfCustomData(header: "메인요리", items: [])]
    
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
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        Observable.just(sections)
            .bind(to: mainDishListTabelView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
}

//AutoLayout
extension MainViewController {
    
}

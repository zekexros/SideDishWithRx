//
//  DetailScrollView.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/12.
//

import UIKit
import SnapKit

class DetailScrollView: UIScrollView {

    let contentView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let imagesScrollView = ImagesScrollView()
    
    let dishInformationStackVIew = DishInformationStackView()
    
    let firstLine: UIView = {
        var view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    let secondeLine: UIView = {
        var view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    let detailInformationStackView = DetailInformationStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(contentView)
        contentView.addSubview(imagesScrollView)
        contentView.addSubview(dishInformationStackVIew)
        contentView.addSubview(firstLine)
        contentView.addSubview(detailInformationStackView)
        contentView.addSubview(secondeLine)
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureImagesScrollView(view: UIView) {
        self.imagesScrollView.configureContentView(view: view)
    }
    
    func configureCell(title: String, description: String, nPrice: String?, sPrice: String, badge: [String?]?) {
        dishInformationStackVIew.configureCell(title: title, description: description, nprice: nPrice, sPrice: sPrice, badge: badge)
    }
    
    func configureDetailInformationStackView(point: String, info: String, fee: String) {
        detailInformationStackView.setUp(point: point, info: info, fee: fee)
    }
}

extension DetailScrollView {
    func configureAutoLayout() {
        contentView.snp.makeConstraints { view in
            view.edges.equalToSuperview()
            view.centerX.centerY.equalToSuperview()
        }
        
        imagesScrollView.snp.makeConstraints { view in
            view.top.leading.trailing.equalToSuperview()
            view.height.equalTo(imagesScrollView.snp.width).multipliedBy(1)
        }
        
        dishInformationStackVIew.snp.makeConstraints { view in
            view.top.equalTo(imagesScrollView.snp.bottom).offset(24)
            view.height.equalTo(150)
            view.leading.equalToSuperview().inset(16)
            view.trailing.equalToSuperview()
        }
        
        firstLine.snp.makeConstraints { line in
            line.top.equalTo(dishInformationStackVIew.snp.bottom).offset(24)
            line.height.equalTo(2)
            line.leading.trailing.equalToSuperview()
        }
        
        detailInformationStackView.snp.makeConstraints { view in
            view.top.equalTo(firstLine.snp.bottom).offset(24)
            view.leading.trailing.equalToSuperview().inset(16)
        }
        
        secondeLine.snp.makeConstraints { line in
            line.top.equalTo(detailInformationStackView.snp.bottom).offset(24)
            line.leading.trailing.bottom.equalToSuperview()
            
        }
    }
}

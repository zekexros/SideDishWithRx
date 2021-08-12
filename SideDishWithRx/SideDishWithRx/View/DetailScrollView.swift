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
    let line: UIView = {
        var view = UIView()
        view.tintColor = .black
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentView.addSubview(imagesScrollView)
        contentView.addSubview(dishInformationStackVIew)
        contentView.addSubview(line)
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
        
        line.snp.makeConstraints { line in
            line.top.equalTo(dishInformationStackVIew.snp.bottom).offset(24)
            line.height.equalTo(1)
            line.leading.trailing.equalToSuperview()
        }
    }
}

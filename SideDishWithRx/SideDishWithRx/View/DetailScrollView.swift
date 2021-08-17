//
//  DetailScrollView.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/12.
//

import UIKit
import SnapKit

final class DetailScrollView: UIScrollView {

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
    
    let secondLine: UIView = {
        var view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    let detailInformationStackView = DetailInformationStackView()
    
    let quantityStackView = QuantityStackView()
    
    let thirdLine: UIView = {
        var view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    let priceTitle: UILabel = {
        var label = UILabel()
        label.text = "총 주문금액"
        label.font = UIFont.systemFont(ofSize: 18)
        label.tintColor = .systemGray
        return label
    }()
    
    let priceLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.tintColor = .systemGray
        return label
    }()
    
    let orderButton: UIButton = {
        var button = UIButton()
        button.setTitle("주문하기", for: .normal)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let detailSectionStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(contentView)
        contentView.addSubview(imagesScrollView)
        contentView.addSubview(dishInformationStackVIew)
        contentView.addSubview(firstLine)
        contentView.addSubview(detailInformationStackView)
        contentView.addSubview(secondLine)
        contentView.addSubview(quantityStackView)
        contentView.addSubview(thirdLine)
        contentView.addSubview(priceTitle)
        contentView.addSubview(priceLabel)
        contentView.addSubview(orderButton)
        contentView.addSubview(detailSectionStackView)
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureImagesScrollView(view: UIView) {
        self.imagesScrollView.configureContentView(view: view)
    }
    
    func setUpDishInformationStackView(title: String, description: String, nPrice: String?, sPrice: String, badge: [String?]?) {
        dishInformationStackVIew.setUpStackView(title: title, description: description, nprice: nPrice, sPrice: sPrice, badge: badge)
        dishInformationStackVIew.setUpFontSize(titleSize: 24, descriptionSize: 16)
    }
    
    func configureDetailInformationStackView(point: String, info: String, fee: String) {
        detailInformationStackView.setUp(point: point, info: info, fee: fee)
    }
}

extension DetailScrollView {
    private func configureAutoLayout() {
        contentView.snp.makeConstraints { view in
            view.edges.equalTo(self)
            view.centerX.equalTo(self)
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
            line.height.equalTo(1)
            line.leading.trailing.equalToSuperview().inset(16)
        }
        
        detailInformationStackView.snp.makeConstraints { view in
            view.top.equalTo(firstLine.snp.bottom).offset(24)
            view.leading.trailing.equalToSuperview().inset(16)
        }
        
        secondLine.snp.makeConstraints { line in
            line.top.equalTo(detailInformationStackView.snp.bottom).offset(24)
            line.height.equalTo(1)
            line.leading.trailing.equalToSuperview().inset(16)
        }
        
        quantityStackView.snp.makeConstraints { view in
            view.top.equalTo(secondLine.snp.bottom).offset(24)
            view.leading.trailing.equalToSuperview().inset(16)
        }
        
        thirdLine.snp.makeConstraints { view in
            view.top.equalTo(quantityStackView.snp.bottom).offset(24)
            view.leading.trailing.equalToSuperview().inset(16)
            view.height.equalTo(1)
        }
        
        priceLabel.snp.makeConstraints { label in
            label.top.equalTo(thirdLine.snp.bottom).offset(24)
            label.leading.equalTo(priceTitle.snp.trailing).offset(24)
            label.trailing.equalToSuperview().inset(16)
        }

        priceTitle.snp.makeConstraints { title in
            title.top.equalTo(thirdLine.snp.bottom).offset(34)
            title.trailing.equalTo(priceLabel.snp.leading).offset(-24)
        }
        
        orderButton.snp.makeConstraints { button in
            button.top.equalTo(thirdLine.snp.bottom).offset(94)
            button.leading.trailing.equalToSuperview().inset(16)
            button.height.equalTo(58)
        }

        detailSectionStackView.snp.makeConstraints { view in
            view.top.equalTo(orderButton.snp.bottom).offset(40)
            view.leading.trailing.bottom.equalToSuperview()
        }
    }
}

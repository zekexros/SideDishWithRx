//
//  DetailInformationStackView.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/13.
//

import UIKit
import SnapKit

class DetailInformationStackView: UIStackView {
    
    let reserveTitle: UILabel = {
        var label = UILabel()
        label.text = "적립금"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let reserveLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let reserveStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 16
        return stackView
    }()
    
    let deliveryInformationTitle: UILabel = {
        var label = UILabel()
        label.text = "배송정보"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let deliveryInformationLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let deliveryInformationStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 16
        return stackView
    }()
    
    let deliveryFeeTitle: UILabel = {
        var label = UILabel()
        label.text = "배송비"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let deliveryFeeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let deliveryFeeStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 16
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        distribution = .fill
        alignment = .leading
        spacing = 16
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        addArrangedSubview(reserveStackView)
        addArrangedSubview(deliveryInformationStackView)
        addArrangedSubview(deliveryFeeStackView)
        
        configureReserveStackView()
        configureDeliveryInformationStackView()
        configureDeliveryFeeStackView()
        
        configureAutoLayout()
    }
    
    func configureReserveStackView() {
        reserveStackView.addArrangedSubview(reserveTitle)
        reserveStackView.addArrangedSubview(reserveLabel)
    }
    
    func configureDeliveryInformationStackView() {
        deliveryInformationStackView.addArrangedSubview(deliveryInformationTitle)
        deliveryInformationStackView.addArrangedSubview(deliveryInformationLabel)
    }
    
    func configureDeliveryFeeStackView() {
        deliveryFeeStackView.addArrangedSubview(deliveryFeeTitle)
        deliveryFeeStackView.addArrangedSubview(deliveryFeeLabel)
    }
    
    func setUp(point: String, info: String, fee: String) {
        self.reserveLabel.text = point
        self.deliveryInformationLabel.text = info
        self.deliveryFeeLabel.text = fee
    }
}

extension DetailInformationStackView {
    func configureAutoLayout() {
        reserveTitle.snp.makeConstraints { title in
            title.width.equalTo(60)
        }
        
        reserveTitle.snp.contentHuggingHorizontalPriority = 500
        
        reserveStackView.snp.makeConstraints { view in
            view.leading.trailing.equalToSuperview()
        }
        
        deliveryInformationTitle.snp.makeConstraints { title in
            title.width.equalTo(60)
        }
        deliveryInformationTitle.snp.contentHuggingHorizontalPriority = 500
        
        deliveryInformationStackView.snp.makeConstraints { view in
            view.leading.trailing.equalToSuperview()
        }
        
        deliveryFeeTitle.snp.makeConstraints { title in
            title.width.equalTo(60)
        }
        deliveryFeeTitle.snp.contentHuggingHorizontalPriority = 500
        
        deliveryFeeStackView.snp.makeConstraints { view in
            view.leading.trailing.equalToSuperview()
        }
    }
}

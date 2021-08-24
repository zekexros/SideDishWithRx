//
//  DetailInformationStackView.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/13.
//

import UIKit
import SnapKit

final class DetailInformationStackView: UIStackView {
    
    private let reserveTitle: UILabel = {
        var label = UILabel()
        label.text = "적립금"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let reserveLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let reserveStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 16
        return stackView
    }()
    
    private let deliveryInformationTitle: UILabel = {
        var label = UILabel()
        label.text = "배송정보"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let deliveryInformationLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let deliveryInformationStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 16
        return stackView
    }()
    
    private let deliveryFeeTitle: UILabel = {
        var label = UILabel()
        label.text = "배송비"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let deliveryFeeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let deliveryFeeStackView: UIStackView = {
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
        distribution = .equalSpacing
        alignment = .leading
        spacing = 16
        configureSubViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureSubViews() {
        addArrangedSubview(reserveStackView)
        addArrangedSubview(deliveryInformationStackView)
        addArrangedSubview(deliveryFeeStackView)
        
        configureReserveStackView()
        configureDeliveryInformationStackView()
        configureDeliveryFeeStackView()
        
        configureAutoLayout()
    }
    
    private func configureReserveStackView() {
        reserveStackView.addArrangedSubview(reserveTitle)
        reserveStackView.addArrangedSubview(reserveLabel)
    }
    
    private func configureDeliveryInformationStackView() {
        deliveryInformationStackView.addArrangedSubview(deliveryInformationTitle)
        deliveryInformationStackView.addArrangedSubview(deliveryInformationLabel)
    }
    
    private func configureDeliveryFeeStackView() {
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
    private func configureAutoLayout() {
        reserveTitle.snp.makeConstraints { title in
            title.width.equalTo(60)
        }
        
        reserveStackView.snp.makeConstraints { view in
            view.leading.trailing.equalToSuperview()
        }
        
        deliveryInformationTitle.snp.makeConstraints { title in
            title.width.equalTo(60)
        }
        
        deliveryInformationStackView.snp.makeConstraints { view in
            view.leading.trailing.equalToSuperview()
        }
        
        deliveryFeeTitle.snp.makeConstraints { title in
            title.width.equalTo(60)
        }
        
        deliveryFeeStackView.snp.makeConstraints { view in
            view.leading.trailing.equalToSuperview()
        }
    }
}

//
//  QuantityStackView.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/13.
//

import UIKit
import SnapKit

class QuantityStackView: UIStackView {
    
    let quantityTitle: UILabel = {
        var label = UILabel()
        label.text = "수량"
        return label
    }()
    
    let quantityLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let upButton: UIButton = {
        var button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.tintColor = .black
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        return button
    }()
    
    let downButton: UIButton = {
        var button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.tintColor = .black
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return button
    }()
    
    let quantityControlStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.systemGray.cgColor
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    let buttonStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .equalSpacing
        axis = .horizontal
        alignment = .fill
        
        configureSubviews()
        configureAutoLayout()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureSubviews() {
        addArrangedSubview(quantityTitle)
        addArrangedSubview(quantityControlStackView)
        
        quantityControlStackView.addArrangedSubview(quantityLabel)
        quantityControlStackView.addArrangedSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(upButton)
        buttonStackView.addArrangedSubview(downButton)
    }
}

extension QuantityStackView {
    func configureAutoLayout() {
        quantityControlStackView.snp.makeConstraints { view in
            view.width.equalTo(90)
            view.height.equalTo(40)
        }
    }
}

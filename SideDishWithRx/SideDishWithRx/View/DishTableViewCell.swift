//
//  DishTableViewCell.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/02.
//

import UIKit
import SnapKit

class DishTableViewCell: UITableViewCell {
    
    static let cellID = "DishTableViewCell"
    let dishPhotography: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    var title = UILabel()
    let dishDescription = UILabel()
    let priceStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    let nPrice = UILabel()
    let sPrice = UILabel()
    let badge = UIView()
    let badgeStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    let dishInformationStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureDishInformationStackView()
        self.addSubviews()
        self.autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spacing = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        contentView.frame = contentView.frame.inset(by: spacing)
    }
    
    func addSubviews() {
        contentView.addSubview(dishPhotography)
        contentView.addSubview(dishInformationStackView)
    }
    
    func configureDishInformationStackView() {
        dishInformationStackView.addArrangedSubview(title)
        dishInformationStackView.addArrangedSubview(dishDescription)
        dishInformationStackView.addArrangedSubview(priceStackView)
    }
    
    
    
    func configurePriceStackView(nPriceValue: String?, sPriceValue: String) {
        priceStackView.subviews.forEach { $0.removeFromSuperview() }
        
        sPrice.text = sPriceValue
        priceStackView.addArrangedSubview(sPrice)
        configurePriceHuggingPriority()
        
        if let nPriceValue = nPriceValue {
            nPrice.text = nPriceValue
            priceStackView.addArrangedSubview(nPrice)
        }
    }
    
    func configureBadgeStackView(badge: [String?]?) {
        badgeStackView.subviews.forEach { $0.removeFromSuperview() }
        
        guard let badge = badge, !badge.compactMap({ $0 }).isEmpty else {
            return
        }

        badge.forEach { badge in
            let badgeLabel = UILabel()
            badgeLabel.text = badge
            badgeStackView.addArrangedSubview(badgeLabel)
        }
        
        dishInformationStackView.addArrangedSubview(badgeStackView)
        badgeStackAutoLayout()
    }
    
    func configureCell(title: String, description: String, nprice: String?, sPrice: String, badge: [String?]?) {
        self.title.text = title
        self.dishDescription.text = description
        
        configurePriceStackView(nPriceValue: nprice, sPriceValue: sPrice)
        configureBadgeStackView(badge: badge)
        
    }
}

extension DishTableViewCell {
    func autoLayout() {
        dishPhotography.snp.makeConstraints { imageView in
            imageView.width.equalTo(dishPhotography.snp.height).multipliedBy(1)
            imageView.top.leading.bottom.equalToSuperview()
        }
        
        dishInformationStackView.snp.makeConstraints { stackView in
            stackView.top.bottom.equalToSuperview()
            stackView.leading.equalTo(dishPhotography.snp.trailing).offset(8)
            stackView.trailing.equalToSuperview().inset(16)
        }
        
    }
    
    func badgeStackAutoLayout() {
        badgeStackView.snp.makeConstraints { stackView in
            stackView.height.equalTo(25)
        }
    }
    
    func configurePriceHuggingPriority() {
        sPrice.snp.contentHuggingHorizontalPriority = 252
    }
}

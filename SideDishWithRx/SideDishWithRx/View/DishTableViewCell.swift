//
//  DishTableViewCell.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/02.
//

import UIKit
import SnapKit

final class DishTableViewCell: UITableViewCell {
    
    static let cellID = "DishTableViewCell"
    let dishPhotography: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private var title = UILabel()
    private let dishDescription = UILabel()
    private let priceStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    private let nPrice = UILabel()
    private let sPrice = UILabel()
    private let badgeStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    private let dishInformationStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
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
    
    override func prepareForReuse() {
        priceStackView.subviews.forEach { $0.removeFromSuperview() }
        badgeStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func addSubviews() {
        contentView.addSubview(dishPhotography)
        contentView.addSubview(dishInformationStackView)
    }
    
    private func configureDishInformationStackView() {
        dishInformationStackView.addArrangedSubview(title)
        dishInformationStackView.addArrangedSubview(dishDescription)
        dishInformationStackView.addArrangedSubview(priceStackView)
    }
    
    private func configurePriceStackView(nPriceValue: String?, sPriceValue: String) {
        sPrice.text = sPriceValue
        priceStackView.addArrangedSubview(sPrice)

        
        if let nPriceValue = nPriceValue {
            let attributedString = changeStrikeThrough(text: nPriceValue)
            nPrice.attributedText = attributedString
            nPrice.textColor = .gray
            priceStackView.addArrangedSubview(nPrice)
        }
    }
    
    private func changeStrikeThrough(text: String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    private func configureBadgeStackView(badge: [String?]?) {
        guard let badge = badge, !badge.compactMap({ $0 }).isEmpty else {
            return
        }

        badge.forEach { badge in
            if badge == "이벤트특가" {
                let badgeLabel = BadgeLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), backgroundColor: .systemIndigo, topInset: 5, bottomInset: 5, leadingInset: 7, trailingInset: 7)
                badgeLabel.text = badge
                badgeStackView.addArrangedSubview(badgeLabel)
            } else {
                let badgeLabel = BadgeLabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0), backgroundColor: .systemYellow, topInset: 5, bottomInset: 5, leadingInset: 7, trailingInset: 7)
                badgeLabel.text = badge
                badgeStackView.addArrangedSubview(badgeLabel)
            }
        }
        
        dishInformationStackView.addArrangedSubview(badgeStackView)
    }
    
    func configureCell(title: String, description: String, nprice: String?, sPrice: String, badge: [String?]?) {
        self.title.text = title
        self.dishDescription.text = description
        
        configurePriceStackView(nPriceValue: nprice, sPriceValue: sPrice)
        configureBadgeStackView(badge: badge)
        
    }
}

extension DishTableViewCell {
    private func autoLayout() {
        dishPhotography.snp.makeConstraints { imageView in
            imageView.width.equalTo(dishPhotography.snp.height).multipliedBy(1)
            imageView.top.leading.bottom.equalToSuperview()
        }
        
        dishInformationStackView.snp.makeConstraints { stackView in
            stackView.top.bottom.equalToSuperview().inset(1)
            stackView.leading.equalTo(dishPhotography.snp.trailing).offset(8)
            stackView.trailing.equalToSuperview().inset(16)
        }
    }
}

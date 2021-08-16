//
//  DishInformationStackView.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/12.
//

import UIKit

class DishInformationStackView: UIStackView {

    private var title: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private let dishDescription = UILabel()
    private let nPrice = UILabel()
    private let sPrice = UILabel()
    private let priceStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    private let badgeStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        distribution = .fillEqually
        alignment = .leading
        
        addArrangeSubviews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
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
        
        addArrangedSubview(badgeStackView)
    }
    
    private func changeStrikeThrough(text: String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func addArrangeSubviews() {
        addArrangedSubview(title)
        addArrangedSubview(dishDescription)
        addArrangedSubview(priceStackView)
    }
    
    func setUpStackView(title: String, description: String, nprice: String?, sPrice: String, badge: [String?]?) {
        self.title.text = title
        self.dishDescription.text = description
        
        configurePriceStackView(nPriceValue: nprice, sPriceValue: sPrice)
        configureBadgeStackView(badge: badge)
    }
    
    func prepareForReuseAsCell() {
        priceStackView.subviews.forEach { $0.removeFromSuperview() }
        badgeStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func setUpFontSize(titleSize: CGFloat, descriptionSize: CGFloat) {
        title.font = UIFont.boldSystemFont(ofSize: titleSize)
        dishDescription.font = UIFont.systemFont(ofSize: descriptionSize)
    }
}

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

    private let dishInformationStackView = DishInformationStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        dishInformationStackView.prepareForReuseAsCell()
    }
    
    private func addSubviews() {
        contentView.addSubview(dishPhotography)
        contentView.addSubview(dishInformationStackView)
    }
    
    func configureCell(title: String, description: String, nprice: String?, sPrice: String, badge: [String?]?) {
        dishInformationStackView.configureCell(title: title, description: description, nprice: nprice, sPrice: sPrice, badge: badge)
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

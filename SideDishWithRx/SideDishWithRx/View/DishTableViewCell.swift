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
    let dishPhotography = UIImageView()
    var title = UILabel()
    let dishDescription = UILabel()
    let nPrice = UILabel()
    let sPrice = UILabel()
    let badge = UIView()
    let stackView = UIStackView()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
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
    
    func addSubviews() {
        addSubview(title)
    }
}

extension DishTableViewCell {
    func autoLayout() {
        title.snp.makeConstraints { title in
            title.edges.equalToSuperview()
        }
    }
}

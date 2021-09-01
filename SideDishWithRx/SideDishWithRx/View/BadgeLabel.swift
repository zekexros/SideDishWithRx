//
//  BadgeLabel.swift
//  SideDishWithRx
//
//  Created by 양준혁 on 2021/08/05.
//

import UIKit

final class BadgeLabel: UILabel {

    private var topInset: CGFloat
    private var bottomInset: CGFloat
    private var leadingInset: CGFloat
    private var trailingInset: CGFloat
    
    init(frame: CGRect, backgroundColor: UIColor, topInset: CGFloat, bottomInset: CGFloat, leadingInset: CGFloat, trailingInset: CGFloat) {
        self.topInset = topInset
        self.bottomInset = bottomInset
        self.leadingInset = leadingInset
        self.trailingInset = trailingInset
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        
        layer.masksToBounds = true
        layer.cornerRadius = 15
    }
    
    override func drawText(in rect: CGRect) {
        let edgeInset = UIEdgeInsets(top: topInset, left: leadingInset, bottom: bottomInset, right: trailingInset)
        super.drawText(in: rect.inset(by: edgeInset))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leadingInset + trailingInset, height: size.height + topInset + bottomInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

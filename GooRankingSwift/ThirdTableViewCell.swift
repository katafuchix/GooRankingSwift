//
//  ThirdTableViewCell.swift
//  GooRankingSwift
//
//  Created by cano on 2017/04/23.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func draw(_ rect: CGRect) {
        drawLine(from: CGPoint(x:0,y:self.frame.height), to: CGPoint(x:self.frame.width,y:self.frame.height))
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        self.layoutIfNeeded()
        var size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        
        if let textLabel = self.textLabel, let detailTextLabel = self.detailTextLabel {
            let detailHeight = detailTextLabel.frame.size.height
            if detailTextLabel.frame.origin.x > textLabel.frame.origin.x { // style = Value1 or Value2
                let textHeight = textLabel.frame.size.height
                if (detailHeight > textHeight) {
                    size.height += detailHeight - textHeight
                }
            } else { // style = Subtitle, so always add subtitle height
                size.height += detailHeight
            }
        }
        
        return size
        
    }

}

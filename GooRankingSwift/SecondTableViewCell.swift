//
//  SecondTableViewCell.swift
//  GooRankingSwift
//
//  Created by cano on 2017/04/23.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {

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
}

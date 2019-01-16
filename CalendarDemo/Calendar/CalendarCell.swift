//
//  CalendarCell.swift
//  CalendarDemo
//
//  Created by Janise on 2019/1/14.
//  Copyright © 2019年 Janise. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config(frame)
    }
    func config(_ frame: CGRect) {
        self.addSubview(self.dateLabel)
        dateLabel.frame = CGRect(x: frame.width/2-(frame.height-10)/2, y: 5, width: frame.height-10, height: frame.height-10)
        dateLabel.layer.cornerRadius = frame.height/2-5
        dateLabel.clipsToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

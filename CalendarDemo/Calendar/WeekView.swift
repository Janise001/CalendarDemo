//
//  WeekView.swift
//  CalendarDemo
//
//  Created by Janise on 2019/1/15.
//  Copyright © 2019年 Janise. All rights reserved.
//

import UIKit

class WeekView: UIView {

    let weekDays: [String] = ["日","一","二","三","四","五","六"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 115/255, green: 201/255, blue: 188/255, alpha: 1)
        for (index,string) in self.weekDays.enumerated() {
            let dayLabel: UILabel = {
                let label = UILabel()
                label.text = string
                label.textColor = UIColor.white
                label.textAlignment = .center
                return label
            }()
            dayLabel.frame = CGRect(x: CGFloat(index)*(frame.width/7), y: 0, width: frame.width/7, height: 30)
            self.addSubview(dayLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

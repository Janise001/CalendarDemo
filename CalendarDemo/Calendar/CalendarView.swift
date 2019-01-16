//
//  CalendarView.swift
//  CalendarDemo
//
//  Created by Janise on 2019/1/14.
//  Copyright © 2019年 Janise. All rights reserved.
//

import UIKit

class CalendarView: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(CalendarCell.self, forCellWithReuseIdentifier: "cell")
        self.backgroundColor = UIColor.white
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = false
    }
    var getDatesBlock: ((UILabel)->())?
    
    var date: Date = Date() {
        didSet {
            //获取日期所在月份的所有日期
            self.weekday = getFirstDayInDateMonth(date) - 1
            print("date所在月份第一天是星期\(self.weekday)")
            self.days = calculateDaysInDateMonth(date)
            print("date所在月份有\(self.days)天")
        }
    }
    /// 指定日期所在月份的第一天是星期几
    var weekday: Int = 0
    /// 指定日期的天数
    var days: Int = 0 {
        didSet {
            self.tempDay = 1
            self.reloadData()
        }
    }
    /// 用于在对应月份中的
    var tempDay: Int = 1
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCell
        if indexPath.row >= self.weekday && indexPath.row < self.weekday + self.days  {
            cell.dateLabel.text = "\(tempDay)"
            tempDay += 1
        }else {
            cell.dateLabel.text = ""
        }
        //点击collectionview中的几个cell后点击“上个月”或者“下个月”按钮获取新的月份信息时，如不加下面的两行会点击的背景出现胡乱排序的问题，还在找原因
        cell.dateLabel.textColor = UIColor.black
        cell.dateLabel.backgroundColor = UIColor.white
        return cell
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCell
        let dayLabel = cell.dateLabel
//        dayLabel.textColor = UIColor.white
//        dayLabel.backgroundColor = UIColor(red: 115/255, green: 201/255, blue: 188/255, alpha: 1)
        self.getDatesBlock?(dayLabel)
    }
   
    /// 获取指定月份的天数
    func calculateDaysInDateMonth(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        //指定日期转换
        let specifiedDateCom = calendar.dateComponents([.year,.month,.day], from: date)
        //指定日期所在月的第一天
        var startCom = DateComponents()
        startCom.day = 1
        startCom.month = specifiedDateCom.month
        startCom.year = specifiedDateCom.year
        let startDate = calendar.date(from: startCom)
        //指定日期所在月的下一个月第一天
        var endCom = DateComponents()
        endCom.day = 1
        endCom.month = specifiedDateCom.month == 12 ? 1 : specifiedDateCom.month! + 1
        endCom.year = specifiedDateCom.month == 12 ? specifiedDateCom.year! + 1 : specifiedDateCom.year
        let endDate = calendar.date(from: endCom)
        //计算指定日期所在月的总天数
        let days = calendar.dateComponents([.day], from: startDate!, to: endDate!)
        let count = days.day ?? 0
        return count
    }
    /// 获取指定日期所在月份的第一天是星期几
    func getFirstDayInDateMonth(_ date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        var specifiedDateCom = calendar.dateComponents([.year,.month], from: date)
        specifiedDateCom.setValue(1, for: .day)
        let startOfMonth = calendar.date(from: specifiedDateCom)
        let weekDayCom = calendar.component(.weekday, from: startOfMonth!)
        return weekDayCom
    }
}

//
//  ViewController.swift
//  CalendarDemo
//
//  Created by 吴丽娟 on 2019/1/14.
//  Copyright © 2019年 Janise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// 视图日历
    var calendarView: CalendarView?
    
    /// 年月显示
    var yearOMonthLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    /// 日历顶部显示年份月份
    var yearOMonth: Date = Date() {
        didSet {
            //年份月份展示label
            self.yearOMonthLabel.text = self.formatYearOMonth(yearOMonth)
            //月份日期展示collectionview
            self.calendarView?.date = yearOMonth
        }
    }
    /// 上一个月份按钮
    var lastButton: UIButton = UIButton()
    /// 下一个月份按钮
    var nextButton: UIButton = UIButton()
    
    var cellWidth: CGFloat = 0.0
    var cellHeight: CGFloat = 0.0
    /// 日历外边框
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor(red: 115/255, green: 201/255, blue: 188/255, alpha: 1).cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()
    /// 日期展示文本
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 115/255, green: 201/255, blue: 188/255, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    /// 日历外边框宽度
    var contentWidth: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "万年历"
        self.contentWidth = self.view.bounds.width-40
        self.cellWidth = (contentWidth/7)
        self.cellHeight = 40
        self.yearOMonthLabel.text = self.formatYearOMonth(self.yearOMonth)
        //上个月按钮
        self.lastButton.setBackgroundImage(UIImage(named: "month_left"), for: .normal)
        self.lastButton.addTarget(self, action: #selector(getLastMonth), for: .touchUpInside)
        self.nextButton.setBackgroundImage(UIImage(named: "month_right"), for: .normal)
        self.nextButton.addTarget(self, action: #selector(getNextMonth), for: .touchUpInside)
        let calendarViewFrame = CGRect(x: 0, y: 70, width: contentWidth, height: 265)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: self.cellWidth, height: self.cellHeight)
        self.calendarView = CalendarView(frame: calendarViewFrame, collectionViewLayout: layout)
        self.contentView.addSubview(self.calendarView ?? UICollectionView())
        self.calendarView?.getDatesBlock = { (label) in
            label.textColor = UIColor.white
            label.backgroundColor = UIColor(red: 115/255, green: 201/255, blue: 188/255, alpha: 1)
            self.dateLabel.text = "\(self.yearOMonthLabel.text ?? "")\(label.text ?? "")日"
        }
        self.calendarView?.date = yearOMonth
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.contentView.frame = CGRect(x: 20, y: 100, width: contentWidth, height: 80+265)
        self.view.addSubview(self.contentView)
        
        self.yearOMonthLabel.frame = CGRect(x: contentWidth/2-100, y: 0, width: 200, height: 30)
        self.contentView.addSubview(yearOMonthLabel)
        
        self.lastButton.frame = CGRect(x: contentWidth/2-100-30, y: 0, width: 30, height: 30)
        self.contentView.addSubview(self.lastButton)
        
        self.nextButton.frame = CGRect(x: contentWidth/2+100, y: 0, width: 30, height: 30)
        self.contentView.addSubview(self.nextButton)
        
        let weekView = WeekView(frame: CGRect(x: 0, y: 30, width: contentWidth, height: 30))
        self.contentView.addSubview(weekView)
        
        self.dateLabel.frame = CGRect(x: 20, y: 160+contentWidth/7*6+60, width: contentWidth, height: 30)
        self.view.addSubview(self.dateLabel)
        
    }
    
    /// 获取上个月的同一日期
    @objc func getLastMonth() {
        let calendar = Calendar.init(identifier: .gregorian)
        var comLast = DateComponents()
        comLast.setValue(-1, for: .month)
        self.yearOMonth = calendar.date(byAdding: comLast, to: self.yearOMonth)!
    }
    /// 获取下个月的同一日期
    @objc func getNextMonth() {
        let calendar = Calendar.init(identifier: .gregorian)
        var comLast = DateComponents()
        comLast.setValue(+1, for: .month)
        self.yearOMonth = calendar.date(byAdding: comLast, to: self.yearOMonth)!
    }
    /// 将日期展示为年月
    func formatYearOMonth(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        let string = formatter.string(from: date)
        return string
    }
    
}


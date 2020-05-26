//
//  LeeTalkSegView.swift
//  YinYinSwift
//
//  Created by jzl on 2019/5/21.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeTalkSegView: UIView {

    var segment : UISegmentedControl?
    var lineView : UIView?
    var moveClouse:((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        segment = UISegmentedControl.init(items: ["精选","最新"])
        segment?.frame = CGRect(x: 0, y: 6, width: 140, height: 30)
        segment?.tintColor = .clear
        segment?.selectedSegmentIndex = 0
        let normalDic = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16) , NSAttributedString.Key.foregroundColor : UIColor.lee_initSingleColor(color: 170)]
        let selectedDic = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 21) , NSAttributedString.Key.foregroundColor : UIColor.lee_initSingleColor(color: 51)]
        segment?.setTitleTextAttributes(normalDic, for: .normal)
        segment?.setTitleTextAttributes(selectedDic, for: .selected)
        segment?.addTarget(self, action: #selector(switchTabAction(segment:)), for: .valueChanged)
        lineView = UIView.init(frame: CGRect(x: 20, y: (segment?.frame.maxY)!, width: 30, height: 2))
        lineView?.backgroundColor = UIColor.lee_initSingleColor(color: 140)
        UIView.lee_radius(view: lineView!, r: 1)
        addSubview(segment!)
        addSubview(lineView!)
    }
    
}

extension LeeTalkSegView{
    func moveIndex(index:Int){
        segment?.selectedSegmentIndex = index
        UIView.animate(withDuration: 0.5, animations: {
            self.lineView?.frame = CGRect(x: 20+index*70, y: (Int(self.segment!.frame.maxY)), width: 30, height: 2)
        })
    }
    
    @objc func switchTabAction(segment:UISegmentedControl){
        self.moveClouse!(segment.selectedSegmentIndex)
        UIView.animate(withDuration: 0.5, animations: {
            self.lineView?.frame = CGRect(x: 20+segment.selectedSegmentIndex * 70, y: (Int(self.segment!.frame.maxY)), width: 30, height: 2)
        })
    }
}

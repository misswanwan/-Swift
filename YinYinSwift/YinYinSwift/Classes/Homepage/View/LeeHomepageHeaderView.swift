//
//  LeeHomepageView.swift
//  YinYinSwift
//
//  Created by jzl on 2019/4/1.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeHomepageHeaderView: UIView{
    var linkClouse:((Int) -> Void)?
    var segClouse:((Int) -> Void)?
    var segView : UISegmentedControl!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        linkUI()
    }
    
    func linkUI(){
        let w = Int(Screen_Width/4)
        let h = 93
        let titleArr :NSArray = ["语聊","共享闺蜜","共享秀照","新手任务"]
        let imageArr :NSArray = ["LeeCommunityUnit1","LeeCommunityUnit2","LeeCommunityUnit3","LeeCommunityUnit4"]
        for title in titleArr{
            let index = titleArr.index(of: title)
            let unitView = UIView.init(frame: CGRect(x: index * w, y: 0, width: w, height: h))
            unitView.tag = index
            let imageView = UIImageView.init(frame: CGRect(x: (w-68)/2, y: 0, width: 60, height: 58))
            imageView.image = UIImage.init(named: imageArr[index] as! String)
            let titleLabel = UILabel.lee_initLabel(frame: CGRect(x: 0, y: Int(imageView.frame.maxY+8), width: w, height: 19), text: title as! String, textColor: UIColor.lee_initSingleColor(color: 45), textA: .center, font: UIFont.systemFont(ofSize: 13))
            unitView.addSubview(imageView)
            unitView.addSubview(titleLabel)
            unitView.isUserInteractionEnabled = true
            let ges = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(ges:)))
            unitView.addGestureRecognizer(ges)
            addSubview(unitView)
        }
        let lineView = UIView.init(frame: CGRect(x: 0, y: h, width: Int(Screen_Width), height: 7))
        lineView.backgroundColor = UIColor.lee_initSingleColor(color: 245)
        segView = UISegmentedControl.init(items: ["热门","最新"])
        segView.selectedSegmentIndex = 0
        segView.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lee_initSingleColor(color: 45),NSAttributedString.Key.font :UIFont.boldSystemFont(ofSize: 18)], for: .selected)
        segView.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lee_initSingleColor(color: 153),NSAttributedString.Key.font :UIFont.systemFont(ofSize: 18)], for: .normal)
        segView.tintColor = UIColor.clear
        segView.frame =  CGRect(x: 8, y: lineView.frame.maxY, width: 100, height: 40)
        segView.addTarget(self, action: #selector(clickSegAction(seg:)), for: .valueChanged)
        addSubview(lineView)
        addSubview(segView)
    }
    
    @objc func clickAction(ges:UITapGestureRecognizer){
        let view = ges.view
        linkClouse!(view!.tag)
    }
 
    @objc func clickSegAction(seg :UISegmentedControl){
        let index = seg.selectedSegmentIndex
        segClouse!(index)
    }
    
    func changeIndex(index:Int){
        segView.selectedSegmentIndex = index
    }
    
}
 

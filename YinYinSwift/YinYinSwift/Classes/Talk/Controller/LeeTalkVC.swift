//
//  LeeTalkVC.swift
//  YinYinSwift
//
//  Created by jzl on 2019/3/18.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeTalkVC: LeeBaseVC{

    var segView : LeeTalkSegView?
    var scrollView : UIScrollView?
    var currentIndex:Int = 0
    var popTalkVC: LeeTalkSubVC = LeeTalkSubVC()
    var latestTalkVC: LeeTalkSubVC = LeeTalkSubVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        segView = LeeTalkSegView.init(frame: CGRect(x: 0, y: lee_statusBarH, width: Screen_Width, height: lee_navH))
        segView?.moveClouse = { [weak self] (index : Int) in
            self?.scrollToIndex(index: index)
        }
        scrollView = UIScrollView.init(frame: CGRect(x: 0.0, y: lee_navTopH, width: Screen_Width, height: Screen_Height - lee_totalH))
        scrollView?.delegate = self
        scrollView?.contentSize = CGSize(width: Screen_Width*3, height: Screen_Height - lee_navTopH)
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.isPagingEnabled = true
        scrollView?.bounces = false
        scrollView?.backgroundColor = .white
        
        view.addSubview(segView!)
        view.addSubview(scrollView!)
        view.backgroundColor = .white
        setChildVCs()
    }
    
    func setChildVCs(){
 
        popTalkVC.talkType = .popTalkType
        latestTalkVC.talkType = .latestTalkType
        let VCs : NSArray = [popTalkVC,latestTalkVC]
        VCs.enumerateObjects { (obj, idx, stop) in
            let controller:UIViewController = obj as! UIViewController
            scrollView?.addSubview(controller.view)
            controller.view.frame = CGRect(x:Double(Screen_Width)*Double(idx), y: Double(0), width: Double(Screen_Width), height: Double(Screen_Height - lee_totalH ))
            self.addChild(controller)
            controller.didMove(toParent: self)
        }
        scrollView?.contentSize = CGSize(width: Double(VCs.count)*Double(Screen_Width), height: Double(Screen_Height - lee_totalH ))
        popTalkVC.loadAction()
    }
    
    func scrollToIndex(index :Int){
        currentIndex = index
        if(currentIndex == 0){
            popTalkVC.loadAction()
        }else if(currentIndex == 1){
            latestTalkVC.loadAction()
        }
        DispatchQueue.main.async(execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.scrollView?.setContentOffset(CGPoint(x: index*Int(Screen_Width), y: 0), animated: true)
            })
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        navigationController?.navigationBar.isHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false;
    }
}

extension LeeTalkVC:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x/Screen_Width)
        if(currentIndex == 0){
            popTalkVC.loadAction()
        }else if(currentIndex == 1){
            latestTalkVC.loadAction()
        }
        self.segView?.moveIndex(index: currentIndex)
    }
}

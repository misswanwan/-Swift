//
//  LeeScrollCell.swift
//  YinYinSwift
//
//  Created by jzl on 2019/4/2.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeScrollCell: UITableViewCell {
    var controllerVCs :NSArray!
    var currentIndex:Int = 0
    var scrollClouse:((Int) -> Void)!
    var cellCanScroll = false
    
    lazy var contentScorllView:UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect(x: 0.0, y: 0, width: Screen_Width, height: Screen_Height - lee_totalH - 40))
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: Screen_Width*2, height: Screen_Height - lee_totalH - 40)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        return scrollView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(contentScorllView)
    }
    
    func setChildVCs(childVCs:NSArray,parentVC:UIViewController){
        controllerVCs = childVCs
        controllerVCs?.enumerateObjects({ (obj, idx, stop) in
            let controller:UIViewController = obj as! UIViewController
            contentScorllView.addSubview(controller.view)
            controller.view.frame = CGRect(x:Int(Screen_Width)*idx, y: 0, width: Int(Screen_Width), height: Int(Screen_Height - lee_totalH - 40))
            parentVC.addChild(controller)
            //当我们向我们的视图控制器容器（就是父视图控制器，它调用addChildViewController方法加入子视图控制器，它就成为了视图控制器的容器）中添加（或者删除）子视图控制器后，必须调用该方法，告诉iOS，已经完成添加（或删除）子控制器的操作。
            controller.didMove(toParent: parentVC)
        })
    }
    
    func scrollToIndex(index :Int){
        currentIndex = index
        scrollClouse!(currentIndex)
        DispatchQueue.main.async(execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.contentScorllView.setContentOffset(CGPoint(x: index*Int(Screen_Width), y: 0), animated: true)
            })
        })
    }
    
    /// 设置cell中的滑动标识
    ///
    /// - Parameter flag:
    func setCanScroll(flag: Bool)  {
        
        self.cellCanScroll = flag
        for vc  in self.controllerVCs {
            var itemObj = vc as! ScrollTabProtocal
            itemObj.vcCanScroll = flag
            if self.cellCanScroll == false {
                //到顶
                itemObj.tableView.contentOffset = CGPoint.zero
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension LeeScrollCell :UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(contentScorllView.contentOffset.x/Screen_Width)
        scrollClouse!(currentIndex)
    }
}

//
//  LeeTalkHeaderView.swift
//  YinYinSwift
//
//  Created by jzl on 2019/5/22.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

let talkIdentifier = "talkIdentifier"

class LeeTalkHeaderView: UIView {
    
    private lazy  var collectionView : UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 77, width: Screen_Width, height: 93), collectionViewLayout: LeeRecommendLayout())
        collectionView.register(LeeTalkRecommendCell.self, forCellWithReuseIdentifier: talkIdentifier)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.lee_convenient(r: 255, g: 246, b: 246)
        return collectionView
    }()
    private var recommendView :UIImageView?
    private var recommendLabel : UILabel?
    private var timer : Timer?
    var recommendData : [LeeTalkModel]?{
        didSet{
            if let data = recommendData{
                collectionView.reloadData()
                DispatchQueue.main.async {
                    if(data.count>0){
                        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
                        self.addTimer()
                    }
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    deinit {
        removeTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(){
        recommendView = UIImageView.init(frame: CGRect(x: 0, y: 30, width: 85, height: 27))
        recommendView?.image = UIImage.init(named: "LeeTalkRecommend")
        recommendLabel = UILabel.lee_initLabel(frame:  CGRect(x: 0, y: 30, width: 85, height: 27), text: "热门推荐", textColor: UIColor.white, textA: .center, font: UIFont.systemFont(ofSize: 13))
        self.addSubview(collectionView)
        self.addSubview(recommendView!)
        self.addSubview(recommendLabel!)
    }
    
    //MARK: action
    @objc func nextImage(){
        let offsetX = collectionView.contentOffset.x
        let page = Int(offsetX/collectionView.bounds.size.width)
        collectionView.contentOffset = CGPoint(x: CGFloat(page)*collectionView.lee_w, y: CGFloat(0))
        collectionView.setContentOffset(CGPoint(x: CGFloat(page+1) * collectionView.lee_w, y: 0), animated: true)
    }
    
    //MARK:timer
    func addTimer(){
        if let _ = timer{
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    
}
//MARK: collection delegate && datasource
extension LeeTalkHeaderView : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = recommendData{
           return  data.count*3
        }
        return  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: talkIdentifier, for: indexPath) as! LeeTalkRecommendCell
        cell.recommendModel = self.recommendData![indexPath.row%recommendData!.count]
        return cell
    }
}

//MARK: scrollview delegate
extension LeeTalkHeaderView : UIScrollViewDelegate{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        var page = Int(offsetX/scrollView.bounds.size.width)
        if(page == 0){
            page = recommendData!.count
            collectionView.contentOffset = CGPoint(x: CGFloat(page)*scrollView.lee_w, y: CGFloat(0))
        }else if(page == collectionView.numberOfItems(inSection: 0) - 1){
            page = recommendData!.count - 1
            collectionView.contentOffset = CGPoint(x: CGFloat(page)*scrollView.lee_w, y: CGFloat(0))
        }
        addTimer()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
 
}

class LeeRecommendLayout : UICollectionViewFlowLayout{
    override func prepare() {
        super.prepare()
        itemSize = (collectionView?.frame.size)!
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        collectionView?.showsHorizontalScrollIndicator = false
    }
}

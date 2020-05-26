//
//  LeeTouchTableView.swift
//  YinYinSwift
//
//  Created by jzl on 2019/4/2.
//  Copyright © 2019年 ww. All rights reserved.
//

import UIKit

class LeeTouchTableView: UITableView {
}

extension LeeTouchTableView:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

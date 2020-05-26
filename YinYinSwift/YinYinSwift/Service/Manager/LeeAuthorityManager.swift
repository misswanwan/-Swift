//
//  LeeAuthorityManager.swift
//  YinYinSwift
//
//  Created by 姜自立 on 2019/8/21.
//  Copyright © 2019 ww. All rights reserved.
//

import Foundation
import AVFoundation

class LeeAuthorityManager: NSObject {
    static func isCanUsePhoto() -> Bool{
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if(authStatus == .denied||authStatus == .restricted){
            return false
        }
        return true
    }
}

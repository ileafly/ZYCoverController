//
//  TopMenuView.swift
//  ZYCoverController_Example
//
//  Created by luzhiyong on 2019/7/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class TopMenuView: UIView {
    
    var backClosure: (() -> Void)?
    
    lazy var backButton: UIButton = {
        let tmp = UIButton(type: .custom)
        tmp.frame = CGRect(x: 20, y: 30, width: 80, height: 30)
        tmp.setTitle("返回", for: .normal)
        tmp.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return tmp
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(white: 0, alpha: 0.7)
        self.addSubview(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backAction() {
        if let backClosure = backClosure {
            backClosure()
        }
    }

}

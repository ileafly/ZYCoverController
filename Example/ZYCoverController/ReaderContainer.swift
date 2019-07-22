//
//  ReaderContainer.swift
//  ZYCoverController_Example
//
//  Created by luzhiyong on 2019/7/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ZYCoverController

class ReaderContainer: UIViewController {
    
    var coverVC: ZYCoverController?
    
    var showMenu: Bool = false
    
    lazy var topMenu: TopMenuView = {
        let tmp = TopMenuView(frame: CGRect(x: 0, y: -menuHeight, width: viewWidth, height: menuHeight))
        tmp.backClosure = {
            self.navigationController?.popViewController(animated: true)
        }
        return tmp
    }()
    
    private let menuHeight: CGFloat = 80.0
    
    private let viewWidth = UIScreen.main.bounds.size.width

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        self.navigationController?.isNavigationBarHidden = true
        
        // 加载翻页容器
        loadFlipController()
        // 加载阅读器内容
        loadReaderContent()
        // 添加点击手势
        addTapGesture()
        // 加载菜单栏
        self.view.addSubview(topMenu)
    }
    
    func loadFlipController() {
        // 加载覆盖翻页
        let coverVC = ZYCoverController()
        coverVC.delegate = self
        addChild(coverVC)
        coverVC.view.frame = view.bounds
        view.addSubview(coverVC.view)
        self.coverVC = coverVC
    }
    
    func loadReaderContent() {
        self.coverVC?.setViewController(ReaderContentController(), isForward: true, animated: true)
    }
    
    func addTapGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGesture(gesture: UITapGestureRecognizer) {
        // gesture location
        let location = gesture.location(in: self.view)
        if location.x < self.view.bounds.size.width / 3 {
            // 向前翻页
            forwardFlip()
        } else if location.x < self.view.bounds.size.width * 2 / 3 {
            // 菜单栏返回
            toggleMenu()
        } else {
            // 向后翻页
            backwardFlip()
        }
    }
    
    // MARK: 菜单栏
    
    func toggleMenu() {
        if self.showMenu {
            UIView.animate(withDuration: 0.3, animations: {
                self.topMenu.frame = CGRect(x: 0, y: -self.menuHeight, width: self.viewWidth, height: self.menuHeight)
            }) { (success) in
                self.showMenu = !self.showMenu
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.topMenu.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.menuHeight)
            }) { (success) in
                self.showMenu = !self.showMenu
            }
        }
    }
    
    // MARK: 翻页事件
    
    func forwardFlip() {
        let contentVC = ReaderContentController()
        self.coverVC?.setViewController(contentVC, isForward: true, animated: true)
    }
    
    func backwardFlip() {
        let contentVC = ReaderContentController()
        self.coverVC?.setViewController(contentVC, isForward: false, animated: true)
    }
}


extension ReaderContainer: ZYCoverControllerDelegate {
    func finishCoverAnimation(_ success: Bool) {
        
    }
    
    func forwardController() -> UIViewController {
        let contentVC = ReaderContentController()
        return contentVC
    }
    
    func nextController() -> UIViewController {
        let contentVC = ReaderContentController()
        return contentVC
    }
}

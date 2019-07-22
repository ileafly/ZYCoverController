//
//  ReaderCoverViewController.swift
//  Nugget
//
//  Created by luzhiyong on 2019/7/18.
//  Copyright © 2019 luzhiyong. All rights reserved.
//

import UIKit

@objc
public protocol ZYCoverControllerDelegate: NSObjectProtocol {
    func finishCoverAnimation(_ success: Bool)
    func forwardController() -> UIViewController
    func nextController() -> UIViewController
}

public class ZYCoverController: UIViewController {
    
    /// 覆盖翻页动画时间，默认为3秒
    public var animateDuration: TimeInterval = 0.3
    
    /// 手势拖拽翻页取消距离，默认为60
    public var animateCancelSpace: Float = 60
    
    /// 代理
    open weak var delegate: ZYCoverControllerDelegate?
    
    /// 当前正在展示的controller
    private var currentController: UIViewController?
    
    /// 下一个要展示的controller
    private var tempController: UIViewController?
    
    /// 动画中 防止滑动过程中多次执行翻页动画
    private var animating: Bool = false
    /// 开始动画 如果为true则可以添加上一页或下一页controller
    private var beginAnimation: Bool = false
    
    /// 页面宽度
    private lazy var viewWidth: CGFloat = {
       return self.view.bounds.width
    }()
    
    private lazy var viewHeight: CGFloat = {
       return self.view.bounds.height
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        // UIPanGesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(touchPanGesture(panGesture:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    // MARK: 公开方法，供外部调用
    /*
     */
    public func setViewController(_ viewController: UIViewController, isForward: Bool, animated: Bool) {
        if animating {
            return
        }
        if animated && currentController != nil {
            animating = true
            addController(viewController, isForward: isForward)
            
            animateCoverController(isForward, animated: animated)
        } else {
            addController(viewController, isForward: isForward)
            
            if currentController != nil {
                currentController?.view.removeFromSuperview()
                currentController?.removeFromParent()
            }
            
            currentController = viewController
        }
    }
    
    // MARK: 私有方法，内部逻辑实现
    /*
     PanGesture 拖拽手势
     */
    @objc func touchPanGesture(panGesture: UIPanGestureRecognizer) {
        // 移动距离
        let translation = panGesture.translation(in: self.view)
        
        if panGesture.state == UIGestureRecognizer.State.began {
            // 开始滑动
            if animating {
                return
            }
            beginAnimation = true
            animating = true
            
        } else if panGesture.state == UIGestureRecognizer.State.changed {
            // 滑动中 移动页面
            if translation.x > 0 {
                if beginAnimation {
                    // 向右滑动，往前翻页
                    if let vc = self.delegate?.forwardController() {
                        addController(vc, isForward: true)
                        tempController = vc
                    }
                    beginAnimation = false
                }
                tempController?.view.frame = CGRect(x: -viewWidth + translation.x, y: 0, width: viewWidth, height: viewHeight)
            } else {
                if beginAnimation {
                    // 向左滑动，向后翻页
                    if let vc = self.delegate?.nextController() {
                        addController(vc, isForward: false)
                        tempController = vc
                    }
                    beginAnimation = false
                }
                currentController?.view.frame = CGRect(x: translation.x, y: 0, width: viewWidth, height: viewHeight)
            }
        } else if panGesture.state == UIGestureRecognizer.State.ended {
            // 滑动结束 判断移动距离是否符合预期 符合预期则翻页成功 否则翻页失败
            if fabsf(Float(translation.x)) > animateCancelSpace {
                // 移动距离超过30
                animateCoverController(translation.x > 0, animated: true)
            } else {
                animateSuccess(translation.x > 0, success: false)
            }
        }
    }
    /*
     添加上一页或下一页 页面
     @params:
     viewController: 要添加的页面控制器
     isForward: 是否是向前翻页 true表示向前，false表示向后
     */
    private func addController(_ viewController: UIViewController, isForward: Bool) {
        addChild(viewController)
        
        if currentController != nil {
            if isForward {
                // 向前翻页
                viewController.view.frame = CGRect(x: -viewWidth, y: 0, width: viewWidth, height: viewHeight)
                // 新页面覆盖在最上层
                view.addSubview(viewController.view)
            } else {
                // 向后翻页
                viewController.view.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
                // 新页面插入在最下层
                view.insertSubview(viewController.view, at: 0)
            }
            // 临时保留tempController
            tempController = viewController
        } else {
            // 直接添加到当前页面
            viewController.view.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
            // 新页面插入在最下层
            view.addSubview(viewController.view)
        }
        addShadow(viewController)
    }
    
    /*
     添加页面阴影
     */
    private func addShadow(_ viewController: UIViewController) {
        viewController.view.layer.shadowColor = UIColor.black.cgColor
        viewController.view.layer.shadowRadius = 10
        viewController.view.layer.shadowOpacity = 0.5
        // 添加shadowPath避免离屏渲染
        viewController.view.layer.shadowPath = UIBezierPath(rect: viewController.view.bounds).cgPath
    }
    
    /*
     动画移动页面布局
    */
    private func animateCoverController(_ isForward: Bool, animated: Bool) {
        if animated {
            // 动画移动内容
            if isForward {
                // 向前翻页
                UIView.animate(withDuration: animateDuration, animations: {
                    self.tempController?.view.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)
                }) { (finish) in
                    self.animateSuccess(isForward, success: finish)
                }
            } else {
                // 向后翻页
                UIView.animate(withDuration: animateDuration, animations:  {
                    self.currentController?.view.frame = CGRect(x: -self.viewWidth, y: 0, width: self.viewWidth, height: self.viewHeight)
                }) { (finish) in
                    self.animateSuccess(isForward, success: finish)
                }
            }
        } else {
            if isForward {
                self.tempController?.view.frame = CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight)
            } else {
                self.currentController?.view.frame = CGRect(x: -self.viewWidth, y: 0, width: self.viewWidth, height: self.viewHeight)
            }
            self.animateSuccess(isForward, success: true)
        }
    }
    
    private func animateSuccess(_ isForward: Bool, success: Bool) {
        if success {
            currentController?.view.removeFromSuperview()
            currentController?.removeFromParent()
            currentController = tempController
            tempController = nil
        } else {
            // 滑动翻页失败，直接恢复
            if isForward {
                // 向前翻页失败
                tempController?.view.frame = CGRect(x: -viewWidth, y: 0, width: viewWidth, height: viewHeight)
            } else {
                // 向后翻页失败
                currentController?.view.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
            }
            
            tempController?.view.removeFromSuperview()
            tempController?.removeFromParent()
        }
        
        delegate?.finishCoverAnimation(success)
        
        animating = false
        
    }

}

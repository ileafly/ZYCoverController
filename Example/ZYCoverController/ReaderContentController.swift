//
//  ReaderContentController.swift
//  ZYCoverController_Example
//
//  Created by luzhiyong on 2019/7/21.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ReaderContentController: UIViewController {
    
    lazy var readerContentView: ReaderContentView = {
       let tmp = ReaderContentView(frame: self.view.bounds.inset(by: UIEdgeInsets(top: 80, left: 15, bottom: 40, right: 15)))
        tmp.attributedString = NSMutableAttributedString(string: "这是阅读页，阅读页的内容是利用CoreText绘制而成，CoreText使用高质量的排版、字符到字形的转换以及在行和段落中定位字形来创建文本布局，CoreText提供了现代的、低等级的代码接口用来布局文本和处理字体，CoreText有几个核心类：CTFramesetter、CTFrame、CTRun、CTLine、CTFont\n\n CTFramesetter提供了创建CTFrame对象的工厂方法 创建framesetter时需要传入富文本字符串 CTFramesetterCreateFrame(CTFramesetterRef framesetter, CFRange stringRange, CGPathRef path, CFDictionaryRef frameAttributes); framesetter用来创建frame stringRange 富文本的range 如果设为0 framesetter就会一直添加到文本渲染完或超出渲染区域 path 指定渲染区域 frameAttributes 一些额外的富文本信息控制样式\n\n CTFrame 包含多行文本的frame 可以使用CTFrame对象在当前的图形上下文绘制文本内容 (CTFrameDraw)\n\n CTFont 表示CoreText的字体对象，提供对字体特征的访问，如字体大小、转换矩阵和其他属性\n\n CTLine 代表一行文本，一个CTLine对象包含一组Runs。CTRun 表示一个图形文字块，它是一组共享相同属性和方向的连续图形")
        return tmp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        self.view.addSubview(readerContentView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

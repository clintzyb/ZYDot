//
//  ZYRedDotView.swift
//  ZYRedDot
//
//  Created by zhu yuanbin on 2017/10/25.
//  Copyright © 2017年 zhuyuanbin. All rights reserved.
//

import UIKit

let font  = UIFont.systemFont(ofSize: 15.0)
let constLeftRightPadding = CGFloat(2.0)
let constTopBottomPadding = CGFloat(2.0)
extension String{
    
    var ZYRedTextSize:CGSize{
        
        var size = CGSize.zero
        if #available(iOS 7.0, *){
            let maxSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
            
            size = self.boundingRect(with:maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:[NSFontAttributeName:font], context: nil).size
        }
        else{
            size = self.size(attributes: [NSFontAttributeName:font])
        }
        if size.width < size.height{
            size.width = size.height
        }
        return size
        
    }
}

/*
 * 默认情况返回不带数字的视图
 * 参数小于0表示不绘制任何数字
 *
 */
open class ZYCountDotView: UIView {
    
    // 默认背景为红色
    @objc lazy var bgColor:UIColor = UIColor.red
    
    // 默认文本颜色为白色
    @objc lazy var textColor:UIColor = UIColor.white
    
    private var _badgeValue:String = "0"
    // 是否绘制文本 在文本长度为0时不绘制
    private var isDrawBadge:Bool = true
    @objc var  badgeTopBottomPadding:CGFloat = constTopBottomPadding
    @objc var  baggeLeftRihtPadding:CGFloat = constLeftRightPadding
    // 使用默认位置(badge添加到父视图的地址)
    @objc var  isUseDefaultPoisition:Bool = true
    
 @objc var badgeValue:Int{
        
        get{
            return Int(self._badgeValue)!
        }
        set{
            if newValue < 0{
                self._badgeValue = ""
            }
            else{
                self._badgeValue = "\(newValue)"
            }
            self.refreshFrame()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    /// 获取zyCountDotView 默认只展示红点
    ///
    /// - Parameter content: 要展示的内容
    /// - Returns:ZYCountDotView
   @objc  class func zyCountDotView(content:Int=(-1))->Self{
        let dotViewObject = self.init()
        dotViewObject._badgeValue = content>0 ? "\(content)":""
        return dotViewObject
        
    }
    
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.backgroundColor = UIColor.clear
        

        self.refreshFrame()
    }
    
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        if true == isUseDefaultPoisition{
            // 默认江badge放在右上角
            guard let superViewUnWrap = self.superview else {
                return
            }
            self.center.x = superViewUnWrap.frame.size.width
            self.center.y = 0.0
        }
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let optionalContext = UIGraphicsGetCurrentContext()
        guard let context = optionalContext else {
            return
        }

        let bodyFrame = self.bounds
        let originPoint = bodyFrame.origin
        
        // 绘制红色背景
        let leftframe = CGRect(x:originPoint.x, y:originPoint.y, width:bodyFrame.size.height, height: bodyFrame.size.height);
        let centerFrame = CGRect(x:originPoint.x+bodyFrame.size.height/2, y:originPoint.y, width:bodyFrame.size.width-bodyFrame.size.height, height: bodyFrame.size.height)
        let rightframe = CGRect(x:originPoint.x+(bodyFrame.size.width-bodyFrame.size.height), y: originPoint.y, width:bodyFrame.size.height, height: bodyFrame.size.height)

        context.setFillColor(self.bgColor.cgColor)
        context.fillEllipse(in: leftframe)
        context.fill(centerFrame)
        context.fillEllipse(in: rightframe)
        
        if true == isDrawBadge{
            // 绘制badgeValue
            context.setFillColor(self.textColor.cgColor)
            let badgeTextStyle = NSMutableParagraphStyle()
            badgeTextStyle.alignment = NSTextAlignment.center
            badgeTextStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            let badgeTextAttribute = [NSFontAttributeName as NSString:font,
                                      NSForegroundColorAttributeName as NSString:self.textColor,
                                      NSParagraphStyleAttributeName as NSString:badgeTextStyle] as [NSAttributedStringKey : Any]
            
            
            
            
            let badgeValueForNSString = self._badgeValue as NSString
            let badgeSize = self._badgeValue.ZYRedTextSize
            badgeValueForNSString.draw(in: CGRect(x: self.baggeLeftRihtPadding,
                                                  y: self.badgeTopBottomPadding,
                                                  width: badgeSize.width,
                                                  height: badgeSize.height),
                                       withAttributes: badgeTextAttribute as [String : Any])
        }

        

        
    }
    
    
    /// 有新的值进来后刷新视图
   @objc  func refreshFrame()->Void{
        
        // 如果初始化没有值那么给高和宽一个默认值
        if self._badgeValue.characters.count == 0{
            self.isDrawBadge = false
            self.frame.size.height = self.badgeTopBottomPadding*2
            self.frame.size.width = self.baggeLeftRihtPadding*2
        }
        else{
            self.isDrawBadge = true
            self.frame.size.height = self._badgeValue.ZYRedTextSize.height+2*self.badgeTopBottomPadding
            self.frame.size.width = self._badgeValue.ZYRedTextSize.width+2*self.baggeLeftRihtPadding
        }
    
    if true == isUseDefaultPoisition{
        guard let superViewUnWrap = self.superview else {
            return
        }
        self.center.x = superViewUnWrap.frame.size.width
        self.center.y = 0.0
    }
        self.setNeedsDisplay()
    }
    
    
    /// 主要难过用于只作为小红点时使用
    ///
    /// - Parameter show: 是否展示
   @objc  func showDot(show:Bool){
        self.isHidden = !show
    }
    

}

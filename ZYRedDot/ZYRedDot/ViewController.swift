//
//  ViewController.swift
//  ZYRedDot
//
//  Created by zhu yuanbin on 2017/10/25.
//  Copyright © 2017年 zhuyuanbin. All rights reserved.
//

import UIKit
var count:Int = 1
class ViewController: UIViewController {
    
    var dotView:ZYCountDotView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView:UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100, height: 100))
        
        myView.backgroundColor = UIColor.green
        myView.center = self.view.center
        self.view.addSubview(myView)
        // Do any additional setup after loading the view, typically from a nib.
        self.dotView = ZYCountDotView.zyCountDotView(content: 1)
        self.dotView?.bgColor = UIColor.blue
        self.dotView?.textColor = UIColor.red
        self.dotView?.moreCount = 1000
        myView.addSubview(self.dotView!)
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(_ sender: Any) {
        count = count+100
//        self.dotView?.updateWithBadge(badge: count)
        self.dotView?.hidenWhenNoCount = true
        self.dotView?.badgeValue = 0
    }
    @IBAction func onlyShowDot(_ sender: Any) {
        self.dotView?.badgeValue = 100
    }
    


}


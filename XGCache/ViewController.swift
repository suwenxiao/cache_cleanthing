//
//  ViewController.swift
//  XGCache
//
//  Created by 苏文潇 on 2017/11/12.
//  Copyright © 2017年 Koalareading. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.backgroundColor = UIColor.orange
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(btnClick1), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(button1)
        
        label.frame = CGRect(x: self.view.center.x/2, y: 100, width: 200, height: 30)
        button.center.x = view.center.x/2 - 20
        button.center.y = view.center.y
        button.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        button1.center.x = view.center.x + 20
        button1.center.y = view.center.y
        button1.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        
    }
    


    
    @objc private func btnClick()
    {
        label.text = XGCache.returenCatchSize() + " Mb"
        let vc = DemoViewController()
    }


    @objc private func btnClick1()
    {
        XGCache.cleanCache { (isTrue) in
            if isTrue
            {
                print("清理完成")
            }
            else
            {
                print("没有可以清理的了")
            }
        }
    }

}


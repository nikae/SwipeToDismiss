//
//  ViewController.swift
//  SwipeToDismiss
//
//  Created by Nika on 11/8/18.
//  Copyright © 2018 Nika. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        button.backgroundColor = .yellow
        button.setTitle("Show PopUp", for: .normal)
        
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        self.view.addSubview(button)
        
        DispatchQueue.main.async {
            self.button.frame.size.width = self.view.bounds.width * 0.3
            self.button.frame.size.height = self.view.bounds.width * 0.3
            self.button.center = self.view.center
            self.button.applyCornerRadius(radius: 10)
        }
    }
    
    @objc func buttonClick(sender: UIButton) {
        let popUpViewController = PopUpViewController()
        self.popUp(popUpViewController)
    }
}


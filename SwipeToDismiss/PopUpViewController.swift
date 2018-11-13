//
//  popUpViewController.swift
//  SwipeToDismiss
//
//  Created by Nika on 11/8/18.
//  Copyright © 2018 Nika. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var popUpView: PopUpView!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addBlurEffect(style: .dark)
        
        self.popUpView = PopUpView(frame: self.view.bounds)
        self.view.addSubview(self.popUpView)
        
        self.panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(wasDragged))
        self.panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(self.panGestureRecognizer)
        
        self.tapToDismiss()
    }
    
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        self.swipeToDismiss(
            self.popUpView,
            self.panGestureRecognizer)
    }
}

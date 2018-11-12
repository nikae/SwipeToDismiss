//
//  PopUpView.swift
//  SwipeToDismiss
//
//  Created by Nika on 11/8/18.
//  Copyright © 2018 Nika. All rights reserved.
//

import UIKit

class PopUpView: UIView {
    
    let containerView = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(containerView)
        
        self.containerView.backgroundColor = .yellow
        self.containerView.applyCornerRadius(radius: 10)
        self.containerView.dropShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.containerView.center = self.center
            self.containerView.frame.size.height = self.bounds.height * 0.7
            self.containerView.frame.size.width = self.bounds.width * 0.7
        }
    }
}


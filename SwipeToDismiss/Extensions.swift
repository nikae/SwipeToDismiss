//
//  Extensions.swift
//  SwipeToDismiss
//
//  Created by Nika on 11/8/18.
//  Copyright © 2018 Nika. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(color: CGColor? = UIColor.darkGray.cgColor) {
        layer.masksToBounds = false
        layer.shadowColor = color
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 3
    }
    
    func applyCornerRadius(radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addBlurEffect(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}

extension UIViewController {
    
    func popUp(_ viewController: UIViewController, animated: Bool = true) {
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: animated, completion: nil)
    }
    
    @objc func selfDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tapToDismiss() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.selfDismiss))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //MARK: Swipe to dismiss viewController:
    /*
     - Make UIPanGestureRecognizer
     - In the action method call:
     swipeToDismiss(_ viewToAnimate: UIView, _ panGesture: UIPanGestureRecognizer)
     */
    
    private var ANIMATION_DURATION: Double { return 0.2 }
    private var MAX_VELOCITY_Y: CGFloat {
        return self.view.bounds.height * 0.4
    }
    private var MAX_VELOCITY_x: CGFloat {
        return self.view.bounds.width * 0.4
    }
    private var originBottom: CGPoint {
        return CGPoint(
            x: self.view.frame.origin.x,
            y: self.view.frame.size.height)
    }
    private var originTop: CGPoint {
        return CGPoint(
            x: -self.view.frame.origin.x,
            y: -self.view.frame.size.height)
    }
    private var originRight: CGPoint {
        return CGPoint(
            x: self.view.frame.size.width,
            y:self.view.frame.origin.y)
    }
    private var originLeft: CGPoint {
        return CGPoint(
            x: -self.view.frame.size.width,
            y: -self.view.frame.origin.y)
    }
    
    fileprivate func animateToDismiss(_ viewToDismiss: UIView, to origin: CGPoint) {
        UIView.animate(withDuration: ANIMATION_DURATION, animations: {
            viewToDismiss.frame.origin = origin
        }, completion: { (isCompleted) in
            if isCompleted {
                self.dismiss(animated: false, completion: nil)
            }
        })
    }
    
    fileprivate func setBackground(alpha: CGFloat) {
        for view in self.view.subviews {
            if view is UIVisualEffectView {
                UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                    view.alpha = alpha
                })
            }
        }
    }
    
    func swipeToDismiss(_ viewToAnimate: UIView, _ panGesture: UIPanGestureRecognizer) {
        
        let velocity = panGesture.velocity(in: view)
        
        let swipeindDown = velocity.y > MAX_VELOCITY_Y
        let swipeindup = velocity.y < -MAX_VELOCITY_Y
        let swipeRight = velocity.x > MAX_VELOCITY_x
        let swipeLeft = velocity.x < -MAX_VELOCITY_x
        
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .changed {
            setBackground(alpha: 0)
            viewToAnimate.frame.origin = CGPoint(
                x: translation.x,
                y: translation.y)
        } else if panGesture.state == .ended {
            if swipeindDown {
                animateToDismiss(viewToAnimate, to: originBottom)
            } else if swipeindup {
                animateToDismiss(viewToAnimate, to: originTop)
            } else if swipeRight {
                animateToDismiss(viewToAnimate, to: originRight)
            } else if swipeLeft {
                animateToDismiss(viewToAnimate, to: originLeft)
            } else {
                setBackground(alpha: 1)
                UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                    viewToAnimate.center = self.view.center
                })
            }
        }
    }
}


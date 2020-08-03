//
//  FadeAnimation.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 24/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class FadeAnimation: NSObject {
    
    private let animationDuration: Double
    private let animationType: AnimationType
    
    enum AnimationType {
        case present
        case dismiss
    }
    
    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuration = animationDuration
        self.animationType = animationType
    }
}

// MARK: - Animation Transition

extension FadeAnimation: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destinationVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        switch animationType {
        case .present:
            present(using: transitionContext, destinationView: destinationVC.view)
        case .dismiss:
            dismiss(using: transitionContext, destinationView: destinationVC.view)
        }
        
    }
    
    private func present(using transitionContext: UIViewControllerContextTransitioning, destinationView: UIView) {
        let blackView = createBlackView(withFrame: destinationView.frame)
        
        transitionContext.containerView.addSubview(destinationView)
        transitionContext.containerView.addSubview(blackView)
        

        blackView.alpha = 0
        destinationView.alpha = 0
        destinationView.clipsToBounds = true
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                blackView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0) {
                destinationView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                blackView.alpha = 0
            }
        }) { (completed) in
            transitionContext.completeTransition(completed)
        }
    }
    
    private func dismiss(using transitionContext: UIViewControllerContextTransitioning, destinationView: UIView) {
        let blackView = createBlackView(withFrame: destinationView.frame)
        
        transitionContext.containerView.addSubview(destinationView)
        transitionContext.containerView.addSubview(blackView)
        
        blackView.alpha = 0
        destinationView.alpha = 0
        destinationView.clipsToBounds = true
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                blackView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0) {
                destinationView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                blackView.alpha = 0
            }
        }) { (completed) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func createBlackView(withFrame frame: CGRect) -> UIView {
        let blackView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        blackView.backgroundColor = .black
        return blackView
    }
}

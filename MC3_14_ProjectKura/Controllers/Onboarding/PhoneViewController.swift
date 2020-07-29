//
//  PhoneViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 28/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {

    @IBOutlet weak var reply: UIImageView!
    
    var didReply = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(screenDidTap)))
    }
    
    @objc private func screenDidTap() {
        if !didReply {
            reply.transform = CGAffineTransform(translationX: 0, y: 30)
            UIView.animate(withDuration: 0.5) {
                self.reply.transform = .identity
                self.reply.alpha = 1
            }
            didReply = true
        } else {
            // Transition
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let destination = storyboard.instantiateViewController(identifier: "CafeViewController")
            destination.modalPresentationStyle = .fullScreen
            present(destination, animated: true, completion: nil)
        }
    }
}

//MARK: - Transition
extension PhoneViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .dismiss)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .present)
    }
}

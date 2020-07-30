//
//  PhoneViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 28/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

protocol PhoneViewControllerDelegate: class {
    func stopBackgroundMusic()
}

class PhoneViewController: UIViewController {

    @IBOutlet weak var reply: UIImageView!
    @IBOutlet weak var phoneImageView: UIImageView!
    
    var didReply = false
    var isReplying = false
    
    weak var delegate: PhoneViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.stopBackgroundMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        phoneImageView.transform = CGAffineTransform(translationX: 100, y: view.frame.height).rotated(by: -.pi / 4).scaledBy(x: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
            self.phoneImageView.transform = .identity
        }, completion: { _ in
            self.showTapAnywhereLabel()
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTap)))
        })
    }
    
    @objc private func didTap() {
        if !didReply && !isReplying {
            isReplying = true
            reply.alpha = 0
            reply.transform = CGAffineTransform(translationX: 0, y: 50)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.reply.alpha = 1
                self.reply.transform = .identity
            }) { (_) in
                self.didReply = true
            }
        } else {
            // Transition
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let destination = storyboard.instantiateViewController(identifier: "CafeViewController")
            destination.modalPresentationStyle = .fullScreen
            present(destination, animated: true, completion: nil)
        }
    }
    
    private func showTapAnywhereLabel() {
        let tapAnywhereLabel = UILabel()
        tapAnywhereLabel.text = "Tap anywhere to continue"
        tapAnywhereLabel.textColor = .black
        tapAnywhereLabel.translatesAutoresizingMaskIntoConstraints = false
        
        guard let customFont = UIFont(name: "Rubik-Regular", size: 16) else { return }
        tapAnywhereLabel.font = customFont
        
        view.addSubview(tapAnywhereLabel)
        NSLayoutConstraint.activate([
            tapAnywhereLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tapAnywhereLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        tapAnywhereLabel.alpha = 0
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse], animations: {
            tapAnywhereLabel.alpha = 1
        }, completion: nil)
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

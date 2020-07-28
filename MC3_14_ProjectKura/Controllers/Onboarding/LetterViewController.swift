//
//  TableViewController.swift
//  MC3_14_ProjectKura
//
//  Created by M Habib Ali Akbar on 28/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class LetterViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var letterImageView: UIImageView!
    @IBOutlet weak var letterPaperImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var phone: UIImageView!
    @IBOutlet weak var letterBuka: UIImageView!
    
    @IBOutlet weak var letterPaperBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var letterPaperCenterXConstraint: NSLayoutConstraint!
    
    var letterPaperShowConstraint: NSLayoutConstraint!
    var isAnimationCompleted = false
    var letterPaperTransformation = CGAffineTransform.identity
    
    let tapAnywhereLabel = UILabel()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateLetter()
        addTapGestureToLetter()
        addTapGestureToScreen()
    }
    
    // MARK: - OBJC Functions
    
    @objc private func letterDidTap() {
        animatePaperLetterShow()
    }
    
    @objc private func screenDidTap() {
        if isAnimationCompleted {
            tapAnywhereLabel.isHidden = true
            letterPaperImageView.gestureRecognizers?.removeAll()
            animatePaperLetterHide()
        }
    }
    
    @objc private func phoneDidTap() {
        print("Phone did tap")
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let destination = storyboard.instantiateViewController(identifier: "PhoneViewController")
        destination.modalPresentationStyle = .fullScreen
        present(destination, animated: true, completion: nil)
    }
    
    // MARK: - Helper Functions
    
    private func showTapAnywhereLabel() {
        tapAnywhereLabel.text = "Tap anywhere to continue"
        tapAnywhereLabel.textColor = .white
        tapAnywhereLabel.translatesAutoresizingMaskIntoConstraints = false
        
        guard let customFont = UIFont(name: "Rubik-Regular", size: 16) else { return }
        tapAnywhereLabel.font = customFont
        
        self.view.addSubview(tapAnywhereLabel)
        NSLayoutConstraint.activate([
            tapAnywhereLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tapAnywhereLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        tapAnywhereLabel.alpha = 0
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.tapAnywhereLabel.alpha = 1
        }, completion: nil)
    }
}

// MARK: - Animations

extension LetterViewController {
    
    private func animatePaperLetterShow() {
        letterPaperBottomConstraint.isActive = false
        letterImageView.layer.removeAllAnimations()
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.letterPaperShowConstraint = self.letterPaperImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
                self.letterPaperShowConstraint.isActive = true
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.letterImageView.transform = CGAffineTransform(translationX: 0, y: 300)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3) {
                self.letterPaperTransformation = self.letterPaperTransformation.rotated(by: CGFloat(-.pi / 2.1))
                self.letterPaperImageView.transform = self.letterPaperTransformation
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                self.letterPaperTransformation = self.letterPaperTransformation.scaledBy(x: 3.5, y: 3.5)
                self.letterPaperImageView.transform = self.letterPaperTransformation
            }
        }, completion: { _ in
            self.isAnimationCompleted = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showTapAnywhereLabel()
            }
        })
    }
    
    private func animatePaperLetterHide() {
        letterPaperShowConstraint.isActive = false
        letterPaperCenterXConstraint.isActive = false
        
        letterImageView.layer.removeAllAnimations()
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.letterPaperShowConstraint.isActive = false
                self.letterPaperImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
                self.letterPaperImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
                
                self.backgroundView.alpha = 0
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.letterPaperTransformation = self.letterPaperTransformation.scaledBy(x: 0.4, y: 0.4).rotated(by: .pi / 10)
                self.letterPaperImageView.transform = self.letterPaperTransformation
                
                self.letterBuka.alpha = 1
            }
        }, completion: { _ in
            self.isAnimationCompleted = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.phone.image = UIImage(named: "PhoneNyala")
                self.addTapGestureToPhone()
                
                // TODO: - Add sound notif hp
            }
        })
    }
    
    private func animateLetter() {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3;
        animationGroup.repeatCount = .infinity

        let pulseAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        pulseAnimation.duration = 0.7
        pulseAnimation.values = [-4, 4, -4, 4, -4, 4, -3, 3, 0]

        animationGroup.animations = [pulseAnimation]

        letterImageView.layer.add(animationGroup, forKey: "pulse")
    }
}

// MARK: - Tap gesture recognizers

extension LetterViewController {
    
    private func addTapGestureToLetter() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(letterDidTap))
        letterImageView.addGestureRecognizer(tapGestureRecognizer)
        letterImageView.isUserInteractionEnabled = true
    }
    
    private func addTapGestureToScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(screenDidTap))
        
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        letterPaperImageView.addGestureRecognizer(tapGestureRecognizer)
        
        backgroundView.isUserInteractionEnabled = true
        letterPaperImageView.isUserInteractionEnabled = true
    }
    
    private func addTapGestureToPhone() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(phoneDidTap))
        
        phone.addGestureRecognizer(tapGestureRecognizer)
        
        phone.isUserInteractionEnabled = true
    }
}

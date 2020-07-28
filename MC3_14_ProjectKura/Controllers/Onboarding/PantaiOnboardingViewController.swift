//
//  PantaiOnboardingViewController.swift
//  MC3_14_ProjectKura
//
//  Created by M Habib Ali Akbar on 27/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class PantaiOnboardingViewController: UIViewController {
    
    @IBOutlet weak var firstWave: UIImageView!
    @IBOutlet weak var secondWave: UIImageView!
    
    @IBOutlet weak var jellyFish: UIImageView!
    @IBOutlet weak var smallJellyFish: UIImageView!
    
    @IBOutlet weak var firstOrangeFish: UIImageView!
    @IBOutlet weak var firstGrayFish: UIImageView!
    @IBOutlet weak var secondOrangeFish: UIImageView!
    @IBOutlet weak var secondGrayFish: UIImageView!
    
    @IBOutlet weak var fishShadow: UIImageView!
    @IBOutlet weak var fishShadow2: UIImageView!
    @IBOutlet weak var fishShadow3: UIImageView!
    @IBOutlet weak var fishShadow4: UIImageView!
    @IBOutlet weak var fishShadow5: UIImageView!
    @IBOutlet weak var fishShadow6: UIImageView!
    @IBOutlet weak var fishShadow7: UIImageView!
    @IBOutlet weak var pantaiBG: UIImageView!
    @IBOutlet weak var koral: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self
        
        // Do any additional setup after loading the view.
        loadAnimation()
    }
    
    private func loadAnimation() {
        
        UIView.animate(withDuration: 3, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.secondWave.transform = CGAffineTransform(translationX: -20, y: 10)
        })
        
        UIView.animate(withDuration: 4, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.firstWave.transform = CGAffineTransform(translationX: 20, y: -10)
        })
        
    }
    
    private func loadAnimationFish() {
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: [.allowUserInteraction, .repeat, .autoreverse, .calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.jellyFish.transform = CGAffineTransform(translationX: 10, y: -20)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.smallJellyFish.transform = CGAffineTransform(translationX: -10, y: 20)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.firstOrangeFish.transform = CGAffineTransform(translationX: 10, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.secondOrangeFish.transform = CGAffineTransform(translationX: -15, y: 5)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.firstGrayFish.transform = CGAffineTransform(translationX: 0, y: 12)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.secondGrayFish.transform = CGAffineTransform(translationX: -5, y: -10)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.fishShadow.transform = CGAffineTransform(translationX: 10, y: -20)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.fishShadow2.transform = CGAffineTransform(translationX: -10, y: 20)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.fishShadow3.transform = CGAffineTransform(translationX: 10, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.fishShadow4.transform = CGAffineTransform(translationX: -15, y: 5)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.fishShadow5.transform = CGAffineTransform(translationX: 0, y: 12)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.fishShadow6.transform = CGAffineTransform(translationX: -5, y: -10)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.fishShadow7.transform = CGAffineTransform(translationX: -5, y: -10)
            }
            
            
        }, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        dismiss(animated: true)
    }
    
}

extension PantaiOnboardingViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .dismiss)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .present)
    }
}

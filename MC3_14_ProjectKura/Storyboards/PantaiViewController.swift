//
//  PantaiViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Vincent Anderson Ngadiman on 21/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class PantaiViewController: UIViewController {

    @IBOutlet weak var firstWave: UIImageView!
    @IBOutlet weak var secondWave: UIImageView!
    @IBOutlet weak var jellyFish: UIImageView!
    @IBOutlet weak var smallJellyFish: UIImageView!
    @IBOutlet weak var firstOrangeFish: UIImageView!
    @IBOutlet weak var firstGrayFish: UIImageView!
    @IBOutlet weak var secondOrangeFish: UIImageView!
    @IBOutlet weak var secondGrayFish: UIImageView!
    
    @IBOutlet weak var pantaiBG: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAnimation()
    }
    
    private func loadAnimation() {
        
        UIView.animate(withDuration: 3, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.secondWave.transform = CGAffineTransform(translationX: -20, y: 10)
        })
        
        UIView.animate(withDuration: 4, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.firstWave.transform = CGAffineTransform(translationX: 20, y: -10)
        })
        
        
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
        }, completion: nil)
    }
    


}

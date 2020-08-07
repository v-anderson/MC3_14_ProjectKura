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
    @IBOutlet var filter: UIImageView!
    
    @IBOutlet weak var papan: UIImageView!
    
    @IBOutlet weak var fishShadow: UIImageView!
    @IBOutlet weak var fishShadow2: UIImageView!
    @IBOutlet weak var fishShadow3: UIImageView!
    @IBOutlet weak var fishShadow4: UIImageView!
    @IBOutlet weak var fishShadow5: UIImageView!
    @IBOutlet weak var fishShadow6: UIImageView!
    @IBOutlet weak var fishShadow7: UIImageView!
    @IBOutlet weak var pantaiBG: UIImageView!
    @IBOutlet weak var koral: UIImageView!
    @IBOutlet var buttonBackToHomeConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var filterGelap: UIView!
    @IBOutlet var kuraChatBox: UILabel!
    @IBOutlet var kuraChatBoxConstraint: NSLayoutConstraint!
    
    
    
    let audioPlayer = AudioPlayer(filename: "beach-waves", extension: "wav")
    
    let texts = [
        "When I was a little turtle, the beach is so pretty and I can play with my friends, swimming, walking around the beach. It’s always been my favorite place.",
        "Me and my family have a job in taking care of the beach. It has been our duty to protect the beaches. We go around to another beach and help the other turtles.",
        "Now that I’ve grown up, it’s time for me to take care of the beach on my own. But it seems to be overwhelming doing this by myself.",
        "The beach will get dirtier if you keep on doing non-eco friendly actions. Try changing your actions to keep the beach clean",
        "The beach condition will change every 3 days according to your daily habit.",
        "Now let’s head back home again by clicking the home sign."
    ]
    
    var textIndex = 0
    var isItFromHome: Bool?
    
    let daysLeftLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterGelap.isHidden = true
        
        transitioningDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willResign), name: UIApplication.willResignActiveNotification, object: nil)
        
        isItFromHome = UserDefaults.standard.object(forKey: "fromHome") as? Bool
        
        if let fromHome = isItFromHome {
            if fromHome {
                filter.alpha = 0
                pantaiBG.image = UIImage(named: "Island Pagi Bersih")
                textIndex = 3
                
                daysLeftLabel.translatesAutoresizingMaskIntoConstraints = false
                daysLeftLabel.text = "3"
                daysLeftLabel.textAlignment = .center
                daysLeftLabel.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
                daysLeftLabel.font = UIFont(name: "Rubik-Bold", size: 22)
                
                papan.isHidden = false
                let moreLabel = UILabel()
                moreLabel.translatesAutoresizingMaskIntoConstraints = false
                moreLabel.text = "more"
                moreLabel.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
                moreLabel.font = UIFont(name: "Rubik-Medium", size: 9)
                
                let daysLabel = UILabel()
                daysLabel.translatesAutoresizingMaskIntoConstraints = false
                daysLabel.text = "days"
                daysLabel.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
                daysLabel.font = UIFont(name: "Rubik-Medium", size: 10)
                
                let verticalStack = UIStackView(arrangedSubviews: [moreLabel, daysLabel])
                verticalStack.translatesAutoresizingMaskIntoConstraints = false
                verticalStack.axis = .vertical
                verticalStack.spacing = -3
                
                papan.addSubview(daysLeftLabel)
                papan.addSubview(verticalStack)
                
                NSLayoutConstraint(item: daysLeftLabel, attribute: .trailing, relatedBy: .equal, toItem: papan, attribute: .centerX, multiplier: 0.82, constant: 0).isActive = true
                NSLayoutConstraint(item: daysLeftLabel, attribute: .centerY, relatedBy: .equal, toItem: papan, attribute: .centerY, multiplier: 0.73, constant: 0).isActive = true
                NSLayoutConstraint(item: verticalStack, attribute: .leading, relatedBy: .equal, toItem: papan, attribute: .centerX, multiplier: 0.9, constant: 0).isActive = true
                
                NSLayoutConstraint.activate([
                    verticalStack.topAnchor.constraint(equalTo: daysLeftLabel.topAnchor, constant: 2),
                ])
            }
        }
    
        kuraChatBox.text = texts[textIndex]
        
        audioPlayer.setupAudioService()
        audioPlayer.playSound(withVolume: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.stopSound()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showtextBox()
    }
    
    @IBAction func backToHomeDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didBecomeActive() {
        print("did become active")
        loadAnimation()
    }
    
    @objc func willResign() {
        print("will enter background")
    }
    
    @objc func tapped() {
        textIndex += 1

        if textIndex == 3 && isItFromHome == nil {
            dismiss(animated: true)
        } else if textIndex == 4 {
            
            filterGelap.isHidden = false
            filterGelap.alpha = 0
            UIView.animate(withDuration: 1) {
                self.filterGelap.alpha = 0.6
            }
            typingAnimation(text: texts[textIndex])
        } else if textIndex == texts.count - 1 {
            UIView.animate(withDuration: 1) {
                self.filterGelap.alpha = 0
            }
            
            UserDefaults.standard.set(nil, forKey: "fromHome")
            view.gestureRecognizers?.removeAll()
            typingAnimation(text: texts[textIndex])
            buttonBackToHomeConstraint.constant = 4
            showtextBox()
        } else {
            if textIndex < texts.count {
                typingAnimation(text: texts[textIndex])
            }
            
        }
        
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
    }
    
    func typingAnimation(text: String) {
        view.gestureRecognizers?.removeAll()
        kuraChatBox.text = ""
        var index = 0.0
        for letter in text {
            kuraChatBox.text?.append(letter)
            
            RunLoop.current.run(until: Date() + 0.02)
            
            index += 1
        }
        addTapGesture()
    }
    
    func showtextBox() {
        kuraChatBoxConstraint.constant = 20
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            self.addTapGesture()
        }
        
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
    
    

    
}

//MARK: - Transition
extension PantaiOnboardingViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .dismiss)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .present)
    }
}

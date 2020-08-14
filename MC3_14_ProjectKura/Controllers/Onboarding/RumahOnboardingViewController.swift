//
//  RumahOnboardingViewController.swift
//  MC3_14_ProjectKura
//
//  Created by M Habib Ali Akbar on 29/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class RumahOnboardingViewController: UIViewController {

    @IBOutlet var kuraChatBox: UILabel!
    @IBOutlet var kuraChatBoxConstraint: NSLayoutConstraint!
    @IBOutlet var tandaSeruButton: UIButton!
//    @IBOutlet var shadowView: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var buttonToBeach: UIButton!
    @IBOutlet var buttonToBeachConstraint: NSLayoutConstraint!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var shadowView2: UIView!
    @IBOutlet var popUpContent1: UIView!
    @IBOutlet var popUpContent2: UIView!
    @IBOutlet var popUpContent3: UIView!
    
    var chatBoxIndex = 0
    var tapIndex = 0
    
    let audioPlayer = AudioPlayer(filename: "after-the-rain", extension: "wav")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transitioningDelegate = self
        addTapGesture()
        
        audioPlayer.setupAudioService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        audioPlayer.playSound(withVolume: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showChatBox()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.lowerSound()
    }
    
    @IBAction func tandaSeruDidTap(_ sender: UIButton) {
        tandaSeruButton.alpha = 0
        popUpView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.popUpView.transform = CGAffineTransform.identity
            self.shadowView.alpha = 0.5
            self.popUpView.alpha = 1
        }
    }
    
    @IBAction func goToBeach(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "fromHome")
        changePage(identifier: "PantaiOnboardingViewController")
        kuraChatBoxConstraint.constant = -300
        buttonToBeachConstraint.constant = -100
        animateChatBox()
    }
    
    @IBAction func popUpButtonDidTap(_ sender: UIButton) {
        popUpContent1.alpha = 0
        popUpContent2.alpha = 1
    }
    
    @IBAction func readMoreDidTap(_ sender: UIButton) {
        popUpContent2.alpha = 0
        popUpContent3.alpha = 1
    }
    
    @IBAction func gotItDidTap(_ sender: UIButton) {
        popUpView.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.shadowView.alpha = 0
        }) { (_) in
            self.popUpView.isHidden = true
            self.showChatBox()
        }
    }
    
    func changePage(identifier: String) {
        var storyboard: UIStoryboard
        
        if identifier == "RumahViewController" {
            storyboard = UIStoryboard(name: "Rumah", bundle: nil)
        } else {
            storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        }
        
        let destination = storyboard.instantiateViewController(identifier: identifier)
        
        destination.modalPresentationStyle = .fullScreen
        
        present(destination, animated: true)
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
    }
    
    func removeTapGesture() {
        view.gestureRecognizers?.removeAll()
    }
    
    @objc func tapped() {
        print(tapIndex)
        if tapIndex == 0 {
            tapIndex += 1
            UIView.animate(withDuration: 1) {
                self.shadowView.alpha = 0.5
                self.tandaSeruButton.alpha = 1
            }
            hideChatBox()
            removeTapGesture()
        } else if tapIndex == 1 {
            UIView.animate(withDuration: 1) {
                self.shadowView2.alpha = 0
            }
            tapIndex += 1
            kuraChatBox.text = ""
            typingAnimation(text: "You can also tap on me to find out more information about our environment facts.")
        } else if tapIndex == 2 {
            
            tapIndex += 1
            kuraChatBox.text = ""
            typingAnimation(text: "Let’s keep making effort to the environment. Remember even your small action will have consequences to the environment")
        }
        else if tapIndex == 3 {
            //onboarding selsesai
            UserDefaults.standard.set(true, forKey: "has_launched_before")
            
            audioPlayer.stopSound()

            if let lastScore = UserDefaults.standard.object(forKey: "last_score") as? Int {
                print("Last score: \(lastScore)\n")
                
                if lastScore < 8 {
                    changeIcon(to: "KuraDirty", completion: { [weak self] in
                        self?.changePage(identifier: "RumahViewController")
                    })
                } else {
                    changePage(identifier: "RumahViewController")
                }
            } else {
                changePage(identifier: "RumahViewController")
            }
        }
    }
    

    
    func showChatBox() {
        switch chatBoxIndex {
        case 0:
            kuraChatBox.text = "This is my home. In here you will find prompt at different times of the day. I will ask you about your daily life. Try tapping one yourself"
            kuraChatBoxConstraint.constant = 20
            chatBoxIndex += 1
        case 1:
            kuraChatBox.text = "Your choices will affect the beach. You can go to the beach by clicking this button"
            kuraChatBoxConstraint.constant = 55
            buttonToBeachConstraint.constant = 4
            chatBoxIndex += 1
        case 2:
            UIView.animate(withDuration: 1) {
                self.shadowView2.alpha = 0.6
            }
            kuraChatBox.text = "Ah, I almost forgot, you can also check on my diary to see my thoughts on you."
            kuraChatBoxConstraint.constant = 20
            addTapGesture()
            chatBoxIndex += 1
        case 3:
            addTapGesture()
            chatBoxIndex += 1
        case 4:
            addTapGesture()
            chatBoxIndex += 1
        default:
            print("")
        }
        animateChatBox()
    }
    
    func hideChatBox() {
        kuraChatBoxConstraint.constant = -300
        animateChatBox()
    }
    
    func animateChatBox() {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
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

}

//MARK: - Transition
extension RumahOnboardingViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .dismiss)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .present)
    }
    
}

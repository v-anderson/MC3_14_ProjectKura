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
    @IBOutlet var shadowView: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var popUpQuestionLabel: UILabel!
    @IBOutlet var popUpButton: UIStackView!
    @IBOutlet var popUpFoodImage: UIImageView!
    @IBOutlet var popUpFactTitleLabel: UILabel!
    @IBOutlet var popUpFactLabel: UILabel!
    
    var chatBoxIndex = 0
    var tapIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        addTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showChatBox()
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
    
    @IBAction func popUpButtonDidTap(_ sender: UIButton) {
        popUpQuestionLabel.alpha = 0
        popUpButton.alpha = 0
        popUpFoodImage.alpha = 1
        popUpFactLabel.alpha = 1
        popUpFactTitleLabel.alpha = 1
        addTapGesture()
    }
    
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
    }
    
    func removeTapGesture() {
        view.gestureRecognizers?.removeAll()
    }
    
    @objc func tapped() {
        if tapIndex == 0 {
            tapIndex += 1
            UIView.animate(withDuration: 1) {
                self.tandaSeruButton.alpha = 1
            }
            hideChatBox()
            removeTapGesture()
        } else if tapIndex == 1 {
            popUpView.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.3, animations: {
                self.popUpView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                self.shadowView.alpha = 0
            }) { (_) in
                self.popUpView.isHidden = true
                self.showChatBox()
            }
        }
    }
    
    func showChatBox() {
        switch chatBoxIndex {
        case 0:
            kuraChatBox.text = "This is my home. In here you will find prompt at different times of the day. I will ask you about your daily life. Try tapping one yourself"
            chatBoxIndex += 1
        case 1:
            kuraChatBox.text = "Your choices will affect the beach. You can go to the beach by clicking this button"
            chatBoxIndex += 1
        default:
            print("last")
        }
        kuraChatBoxConstraint.constant = 20
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
    
    

}

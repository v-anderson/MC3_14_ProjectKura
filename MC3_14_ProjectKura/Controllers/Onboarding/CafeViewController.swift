//
//  CafeViewController.swift
//  MC3_14_ProjectKura
//
//  Created by M Habib Ali Akbar on 27/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//





import UIKit

class CafeViewController: UIViewController {
    
    @IBOutlet weak var chatboxConstraints: NSLayoutConstraint!
    @IBOutlet var inputNameConstraint: NSLayoutConstraint!
    @IBOutlet var inputNameTextField: UITextField!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var chatboxWidthConstraint: NSLayoutConstraint!
    @IBOutlet var singleButton: UIButton!
    @IBOutlet var singleButtonConstraint: NSLayoutConstraint!
    @IBOutlet var stackButton1: UIButton!
    @IBOutlet var stackButton2: UIButton!
    @IBOutlet var stackButtonConstraint: NSLayoutConstraint!
    
    var hasMovedToAnotehrPage = false
    var questionIndex = 0
    var greetingIndex = 0
    let greeting = [
        "Hello! I’m Kura.\nYou must be....",
        "Nice to meet you.\nThank you for meeting me here!  My father believe that you can help me. But I’m still not sure, "
    ]
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTapGesture()
        
        chatLabel.text = greeting[0]
        
        inputNameTextField.delegate = self
        transitioningDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if questionIndex == 5 && !hasMovedToAnotehrPage{
            hasMovedToAnotehrPage = true
            nextQuestion(currentAnswer: nil)
        }
        
        chatboxConstraints.constant = 20
        constraintAnimation()
    }
    
    @IBAction func singleButtonTapped(_ sender: UIButton) {
        nextQuestion(currentAnswer: 0)
        
    }
    
    @IBAction func stackButton1Tapped(_ sender: UIButton) {
        nextQuestion(currentAnswer: 0)
    }
    
    @IBAction func stackButton2Tapped(_ sender: UIButton) {
        nextQuestion(currentAnswer: 1)
    }
    
    func typingAnimation(text: String) {
        chatLabel.text = ""
        
        var text2 = text
        //           if currentIndex == 1 {
        //               text2 = "Hi \(nameInput.text!), " + text
        //           }
        //           label.text = ""
        var index = 0.0
        
        for letter in text2 {
//            Timer.scheduledTimer(withTimeInterval: 0.02 * index, repeats: false) { (timer) in
//                self.chatLabel.text?.append(letter)
//            }
            
            chatLabel.text?.append(letter)
            
            RunLoop.current.run(until: Date() + 0.02)
        
            index += 1
        }
        
        print("dfdfdfdfd")
    }
    
    private func constraintAnimation() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    @objc func tapped() {
        print("tapped")
        removeTapGesture()
        //MARK: - Tap pertama kali
        if greetingIndex == 0 {
            inputNameConstraint.constant = 30
            chatboxConstraints.constant = -300
            inputNameTextField.becomeFirstResponder()
            constraintAnimation()
        //MARK: - Tap setelah mengisi nama
        } else if greetingIndex == 1 {
            chatLabel.text = ""
            showQuestion()
            
        }
        greetingIndex += 1

    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
    }
    
    private func removeTapGesture() {
        view.gestureRecognizers?.removeAll()
    }
    
    func changePage() {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        
        let destination = storyboard.instantiateViewController(identifier: "PantaiOnboardingViewController")
        
        destination.modalPresentationStyle = .fullScreen
        
        present(destination, animated: true)
    }
    
}

//MARK: - Text Field Delegate
extension CafeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if inputNameTextField.text == "" {
            inputNameConstraint.constant += 20
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            inputNameConstraint.constant -= 20
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            inputNameTextField.resignFirstResponder()
            inputNameConstraint.constant = -300
            chatboxConstraints.constant = 20
            chatLabel.text = greeting[greetingIndex]
            chatboxWidthConstraint.constant = 100
            constraintAnimation()
            addTapGesture()
        }
        return true
    }
}

//MARK: - Questions

extension CafeViewController {
    
    func showQuestion() {
        singleButton.setTitle(onboardingQuestions[questionIndex].answers[0], for: .normal)
        typingAnimation(text: onboardingQuestions[questionIndex].question)
        if onboardingQuestions[questionIndex].questionsType == .single {
            singleButtonConstraint.constant = 20
            stackButtonConstraint.constant = -150
            constraintAnimation()
            
        } else {
            singleButtonConstraint.constant = -100
            stackButtonConstraint.constant = 20
        }
        
    }
    
    func showAnswer(answerType: OnboardingCuestionType) {
        print(answerType)
        if answerType == .single {
            
            hideButtonQuestion()
            
            singleButton.setTitle(onboardingQuestions[questionIndex].answers[0], for: .normal)
            
            typingAnimation(text: onboardingQuestions[questionIndex].question)
            
            showButtonQuestion()
        } else {

            hideButtonQuestion()
  
            stackButton1.setTitle(onboardingQuestions[questionIndex].answers[0], for: .normal)
            stackButton2.setTitle(onboardingQuestions[questionIndex].answers[1], for: .normal)
            
            typingAnimation(text: onboardingQuestions[questionIndex].question)
            
            showButtonQuestion()
        }
    }
    
  
    
    func hideButtonQuestion() {
        
        if onboardingQuestions[questionIndex - 1].questionsType == .single{
            singleButtonConstraint.constant = -100
        } else {
            stackButtonConstraint.constant = -150
        }
        constraintAnimation()
    }
    
    func showButtonQuestion() {
        if onboardingQuestions[questionIndex].questionsType == .single{
            singleButtonConstraint.constant = 20
        } else {
            stackButtonConstraint.constant = 20
        }
        constraintAnimation()

    }
    
    func nextQuestion(currentAnswer: Int?) {
        
        if questionIndex == 5 && !hasMovedToAnotehrPage{
            changePage()
        } else {
            questionIndex += 1
            
            if onboardingQuestions[questionIndex].isLongQuestion {
                chatboxWidthConstraint.constant = 100
            } else {
                chatboxWidthConstraint.constant = 0
            }
            
            chatLabel.text = ""
            
            if onboardingQuestions[questionIndex].questionsType == .single {
                showAnswer(answerType: .single)
            } else {
                showAnswer(answerType: .multi)
            }
        }
        
    }
}

//MARK: - Transition
extension CafeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .dismiss)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .present)
    }
}


//extension UIButton {
//
//    func makeMultiLineSupport() {
//        guard let titleLabel = titleLabel else {
//            return
//        }
//        titleLabel.numberOfLines = 0
//        titleLabel.setContentHuggingPriority(.required, for: .vertical)
//        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
//        addConstraints([
//            .init(item: titleLabel,
//                  attribute: .top,
//                  relatedBy: .greaterThanOrEqual,
//                  toItem: self,
//                  attribute: .top,
//                  multiplier: 0.1,
//                  constant: contentEdgeInsets.top),
//            .init(item: titleLabel,
//                  attribute: .bottom,
//                  relatedBy: .greaterThanOrEqual,
//                  toItem: self,
//                  attribute: .bottom,
//                  multiplier: 0.1,
//                  constant: contentEdgeInsets.bottom),
//            .init(item: titleLabel,
//                  attribute: .left,
//                  relatedBy: .greaterThanOrEqual,
//                  toItem: self,
//                  attribute: .left,
//                  multiplier: 0.1,
//                  constant: contentEdgeInsets.left),
//            .init(item: titleLabel,
//                  attribute: .right,
//                  relatedBy: .greaterThanOrEqual,
//                  toItem: self,
//                  attribute: .right,
//                  multiplier: 0.1,
//                  constant: contentEdgeInsets.right)
//            ])
//    }
//
//}


//        pindah halaman


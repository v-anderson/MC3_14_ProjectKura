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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        chatboxConstraints.constant = 20
        constraintAnimation(delay: 0)
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
            Timer.scheduledTimer(withTimeInterval: 0.02 * index, repeats: false) { (timer) in
                self.chatLabel.text?.append(letter)
            }
            
            index += 1
        }
    }
    
    private func constraintAnimation(delay: Int) {
        UIView.animate(withDuration: 1, delay: TimeInterval(delay), usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    @objc func tapped() {
        print("tapped")
        //MARK: - Tap pertama kali
        if greetingIndex == 0 {
            removeTapGesture()
            inputNameConstraint.constant = 30
            chatboxConstraints.constant = -300
            inputNameTextField.becomeFirstResponder()
            constraintAnimation(delay: 0)
        //MARK: - Tap setelah mengisi nama
        } else if greetingIndex == 1 {
            chatLabel.text = ""
            showQuestion()
            removeTapGesture()
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
            constraintAnimation(delay: 0)
            addTapGesture()
        }
        return true
    }
}

//MARK: - Questions

extension CafeViewController {
    
    func showQuestion() {
        typingAnimation(text: onboardingQuestions[questionIndex].question)
        if onboardingQuestions[questionIndex].questionsType == .single {
            singleButton.setTitle(onboardingQuestions[questionIndex].answers[0], for: .normal)
            singleButtonConstraint.constant = 20
            stackButtonConstraint.constant = -150
            constraintAnimation(delay: 1)
            
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
        constraintAnimation(delay: 0)
    }
    
    func showButtonQuestion() {
        if onboardingQuestions[questionIndex].questionsType == .single{
            singleButtonConstraint.constant = 20
        } else {
            stackButtonConstraint.constant = 20
        }
        constraintAnimation(delay: 1)

    }
    
    func nextQuestion(currentAnswer: Int) {
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
//        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
//
//        let destination = storyboard.instantiateViewController(identifier: "PantaiOnboardingViewController")
//
//        destination.modalPresentationStyle = .fullScreen
//
//        present(destination, animated: true)

//
//  RumahViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Vincent Anderson Ngadiman on 20/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit
import UserNotifications

class RumahViewController: UIViewController {

    @IBOutlet weak var tandaSeru: UIButton!
    
    @IBOutlet weak var tandaSeru2: UIButton!
    
    @IBOutlet weak var filter: UILabel!
    @IBOutlet weak var jendela: UIImageView!
    
    @IBOutlet weak var lampu: UIImageView!
    
    // FOOD QUESTIONS
    @IBOutlet weak var backgroundDimmer: UIView!
    // VIEW
    @IBOutlet weak var viewPopUpBox: UIView!
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var viewHeaders: UIView!
    @IBOutlet weak var viewBody: UIView!
    
    @IBOutlet weak var factImage: UIImageView!
    @IBOutlet weak var foodQuestions: UILabel!
    @IBOutlet weak var factTitle: UILabel!
    @IBOutlet weak var factBody: UILabel!
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var popUpBox: UIImageView!
    @IBOutlet weak var lblTapToDismiss: UILabel!
    @IBOutlet weak var btnStack: UIStackView!
    
    
    // notif center property
    let date = Date()
    var dateComponents = DateComponents()
    var randomQuestions: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewAlpha()
        if isMorning() {
            perubahanPagi()
        }
        else if isAfternoon() {
            perubahanSore()
        }
        else {
            perubahanMalam()
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonDidTap)))
    }
    
    @objc func buttonDidTap() {
        let rumahStoryboard = UIStoryboard(name: "Pantai", bundle: nil)
        guard let destinationVC = rumahStoryboard.instantiateViewController(identifier: "PantaiViewController") as? PantaiViewController else { return }
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC, animated: true, completion: nil)
    }
    
    func initialViewAlpha() {
        backgroundDimmer.alpha = 0
        viewPopUpBox.isHidden = true
    }
    
    //ini yang tombol tanda seru untuk munculin pertanyaan makananÏ
    @IBAction func tanyaMakanan(_ sender: Any) {
        tandaSeru.isHidden = true
        randomQuestions = Int.random(in: 0..<3)
        foodQuestion()
    }
    
    func foodQuestion() {
        viewPopUpBox.isHidden = false
        viewPopUpBox.alpha = 0
        viewPopUpBox.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.viewPopUpBox.transform = CGAffineTransform.identity
            self.backgroundDimmer.alpha = 0.5
            self.viewPopUpBox.alpha = 1
            self.lblTapToDismiss.alpha = 0
            self.factImage.alpha = 0
            self.factTitle.alpha = 0
            self.factBody.alpha = 0
        }
        
        foodQuestions.numberOfLines = 0
        foodQuestions.adjustsFontSizeToFitWidth = true
        if let index = randomQuestions{
            foodQuestions.text = questions[index].questions
            btnOption1.setTitle(questions[index].answers[0], for: .normal)
            btnOption2.setTitle(questions[index].answers[1], for: .normal)
        }
        
    }
    
    func fact() {
        factImage.alpha = 1
        factTitle.alpha = 1
        factBody.alpha = 1
        foodQuestions.alpha = 0
        btnStack.isHidden = true
        
        if let index = randomQuestions {
            factImage.image = UIImage(named: questions[index].imageName)
            factTitle.text = questions[index].factTitle
            factBody.text = questions[index].factBody
            lblTapToDismiss.alpha = 1
            factBody.adjustsFontSizeToFitWidth = true
            factBody.numberOfLines = 0
        }
        addTapGesture()
    }
    
    @IBAction func btn1(_ sender: Any) {
        fact()
    }
    
    @IBAction func btn2(_ sender: Any) {
        fact()
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss))
        viewPopUpBox.addGestureRecognizer(tap)
    }
    
    @objc func tapToDismiss() {
        print("test")
        viewPopUpBox.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3, animations: {
            self.viewPopUpBox.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.backgroundDimmer.alpha = 0
        }) { (_) in
            self.viewPopUpBox.isHidden = true
            self.viewPopUpBox.gestureRecognizers?.removeAll()
        }
    }
    
    
    
    //ini tombol tanda seru untuk munculin pertanyaan listrik
    @IBAction func tanyaListrik(_ sender: Any) {
        tandaSeru2.isHidden = true
        UserDefaults.standard.set(Date(), forKey: "last_tappedListrik")
        
    }
    
    private func perubahanPagi() {
        //panggil function ini buat perubahan background waktu pagi
        filter.backgroundColor = UIColor.white.withAlphaComponent(0)
        jendela.image = UIImage(named: "asset.JendelaPagi")
        
        tandaSeru2.isHidden = false
        tandaSeru.isHidden = false
    }
    
    private func perubahanSore() {
        //panggil function ini buat perubahan background waktu sore
        filter.gradientSore(view: filter)
        jendela.image = UIImage(named: "asset.JendelaSore")
        tandaSeru.isHidden = false

        guard let lastTappedListrik = UserDefaults.standard.object(forKey: "last_tappedListrik") as? Date else { return }
        
        let diff = Calendar.current.dateComponents([.day], from: lastTappedListrik, to: Date())
        
        if  diff.day == 0 {
            tandaSeru2.isHidden = true
        }
    }
    
    private func perubahanMalam() {
        //panggil function ini buat perubahan background waktu malam
        filter.gradientMalam(view: filter)
        jendela.image = UIImage(named: "asset.JendelaMalam")
        tandaSeru.isHidden = false
        
        guard let lastTappedListrik = UserDefaults.standard.object(forKey: "last_tappedListrik") as? Date else { return }
        
        let diff = Calendar.current.dateComponents([.day], from: lastTappedListrik, to: Date())
        
        if  diff.day == 0 {
            tandaSeru2.isHidden = true
        }
    }
}

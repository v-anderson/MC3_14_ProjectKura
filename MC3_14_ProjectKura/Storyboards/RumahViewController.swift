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
    @IBOutlet weak var viewPopUpBox: UIView!
    @IBOutlet weak var viewContents: UIView!
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
    let randomQuestions = Int.random(in: 0..<3)
    
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
        
    }
    
    func initialViewAlpha() {
        backgroundDimmer.alpha = 0
        viewPopUpBox.isHidden = true
    }
    
    //ini yang tombol tanda seru untuk munculin pertanyaan makanan
    @IBAction func tanyaMakanan(_ sender: Any) {
        tandaSeru.isHidden = true
        foodQuestion()
    }
    
    func foodQuestion() {
        backgroundDimmer.alpha = 0.5
        viewPopUpBox.isHidden = false
        lblTapToDismiss.alpha = 0
        factImage.alpha = 0
        factTitle.alpha = 0
        factBody.alpha = 0
        foodQuestions.text = questions[randomQuestions].questions
        btnOption1.setTitle(questions[randomQuestions].answers[0], for: .normal)
        btnOption2.setTitle(questions[randomQuestions].answers[1], for: .normal)
    }
    
    func fact() {
        factImage.alpha = 1
        factTitle.alpha = 1
        factBody.alpha = 1
        foodQuestions.alpha = 0
        btnStack.isHidden = true
        factImage.image = UIImage(named: questions[randomQuestions].imageName)
        factTitle.text = questions[randomQuestions].factTitle
        factBody.text = questions[randomQuestions].factBody
        lblTapToDismiss.alpha = 1
        factBody.adjustsFontSizeToFitWidth = true
        factBody.numberOfLines = 0
        
    }
    
    @IBAction func btn1(_ sender: Any) {
        fact()
    }
    
    @IBAction func btn2(_ sender: Any) {
        fact()
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

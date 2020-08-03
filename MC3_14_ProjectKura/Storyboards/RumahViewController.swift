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
    
    @IBOutlet weak var tandaSeruKipas: UIButton!
    
    @IBOutlet weak var tandaSeruShoppingBag: UIButton!
    
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
    @IBOutlet weak var lblQuestionsTitle: UILabel!
    @IBOutlet weak var lblFactTitle: UILabel!
    @IBOutlet weak var lblFactBody: UILabel!
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var popUpBox: UIImageView!
    @IBOutlet weak var lblTapToDismiss: UILabel!
    @IBOutlet weak var stackButton: UIStackView!
    @IBOutlet weak var buttonKePantai: UIButton!
    
    // notif center property
    let date = Date()
    var dateComponents = DateComponents()
    var randomQuestions: Int?
    var factType: FactType?
    
    enum FactType {
        case food
        case electric
        case shoppingBag
        case kipas
    }
    
    let audioPlayer = AudioPlayer(filename: "after-the-rain", extension: "wav")
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewAlpha()
        checkTimeOfDay()
        audioPlayer.setupAudioService()
        transitioningDelegate = self
        buttonKePantai.transform = CGAffineTransform(translationX: 100, y: 0)
        
        let scores = Score.fetchAll(fromContext: getViewContext())
        print("\nCore data contents:")
        for (i, score) in scores.enumerated() {
            print("\(i+1). Score: \(score.score)  | Date: \(score.date)")
        }
        print("")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        audioPlayer.playSound(withVolume: 1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.lowerSound()
        hideButtonKePantai()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButtonKePantai()
    }
    
    // MARK: - IBActions
    
    //ini yang tombol tanda seru untuk munculin pertanyaan makananÏ
    @IBAction func tanyaMakanan(_ sender: Any) {
        tandaSeru.isHidden = true
        randomQuestions = Int.random(in: 0..<FoodQuestions.count)
        factType = .food
        foodQuestion()
    }
    
    //ini tombol tanda seru untuk munculin pertanyaan listrik
    @IBAction func tanyaListrik(_ sender: Any) {
        tandaSeru2.isHidden = true
        randomQuestions = Int.random(in: 0..<electricityQuestions.count)
        factType = .electric
        electricQuestion()
    }
    
    @IBAction func tanyaShoppingBag(_ sender: Any) {
        tandaSeruShoppingBag.isHidden = true
        randomQuestions = Int.random(in: 0..<shoppingBagQuestions.count)
        factType = .shoppingBag
        shoppingBagQuestion()
    }

    @IBAction func tanyaKipas(_ sender: Any) {
        tandaSeruKipas.isHidden = true
        randomQuestions = Int.random(in: 0..<kipasQuestions.count)
        factType = .kipas
        kipasQuestion()
        
    }
    
    @IBAction func btn1(_ sender: Any) {
        checkAnswer(forSelectedButton: 0)
        switch factType {
        case .food:
            UserDefaults.standard.set(Date(), forKey: "last_tappedMakanan")
            foodFact()
        case .electric:
            UserDefaults.standard.set(Date(), forKey: "last_tappedListrik")
            electricFact()
        case .shoppingBag:
            UserDefaults.standard.set(Date(), forKey: "last_tappedShoppingBag")
            shoppingBagFact()
        case .kipas:
            UserDefaults.standard.set(Date(), forKey: "last_tappedKipas")
            kipasFact()
        default:
            return
        }
    }
    
    @IBAction func btn2(_ sender: Any) {
        checkAnswer(forSelectedButton: 1)
        switch factType {
        case .food:
            UserDefaults.standard.set(Date(), forKey: "last_tappedMakanan")
            foodFact()
        case .electric:
            UserDefaults.standard.set(Date(), forKey: "last_tappedListrik")
            electricFact()
        case .shoppingBag:
            UserDefaults.standard.set(Date(), forKey: "last_tappedShoppingBag")
            shoppingBagFact()
        case .kipas:
            UserDefaults.standard.set(Date(), forKey: "last_tappedKipas")
            kipasFact()
        default:
            return
        }
    }
    
    @IBAction func kePantai(_ sender: Any) {
        let rumahStoryboard = UIStoryboard(name: "Pantai", bundle: nil)
        guard let destinationVC = rumahStoryboard.instantiateViewController(identifier: "PantaiViewController") as? PantaiViewController else { return }
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC, animated: true, completion: nil)
    }
    
    // MARK: - OBJC Selectors
    
    @objc func tapToDismiss() {
        viewPopUpBox.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3, animations: {
            self.viewPopUpBox.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.backgroundDimmer.alpha = 0
        }) { (_) in
            self.viewPopUpBox.isHidden = true
            self.viewPopUpBox.gestureRecognizers?.removeAll()
        }
    }
    
    // MARK: - Helper functions
    
    private func checkAnswer(forSelectedButton buttonIndex: Int) {
        if let index = randomQuestions {
            let correctIndex = FoodQuestions[index].goodAnswer
            if correctIndex == buttonIndex {
                print("Good Answer")
                // Insert to core data
                Score.add(toContext: getViewContext(), score: 1)
            } else {
                print("Bad Answer")
            }
        }
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToDismiss))
        viewPopUpBox.addGestureRecognizer(tap)
    }
    
    func initialViewAlpha() {
        backgroundDimmer.alpha = 0
        viewPopUpBox.isHidden = true
    }
    
    func showPopUpBox() {
        viewPopUpBox.isHidden = false
        viewPopUpBox.alpha = 0
        viewPopUpBox.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.viewPopUpBox.transform = CGAffineTransform.identity
            self.backgroundDimmer.alpha = 0.5
            self.viewPopUpBox.alpha = 1
            self.lblQuestionsTitle.alpha = 1
            self.stackButton.isHidden = false
            self.lblTapToDismiss.alpha = 0
            self.factImage.alpha = 0
            self.lblFactTitle.alpha = 0
            self.lblFactBody.alpha = 0
        }
        lblQuestionsTitle.numberOfLines = 0
        lblQuestionsTitle.adjustsFontSizeToFitWidth = true
    }
    
    func hideQuestionsShowFact() {
        factImage.alpha = 1
        lblFactTitle.alpha = 1
        lblFactBody.alpha = 1
        lblQuestionsTitle.alpha = 0
        stackButton.isHidden = true
    }
    
    // Q FOOD
    func foodQuestion() {
        showPopUpBox()
        if let index = randomQuestions{
            lblQuestionsTitle.text = FoodQuestions[index].questions
            btnOption1.setTitle(FoodQuestions[index].answers[0], for: .normal)
            btnOption2.setTitle(FoodQuestions[index].answers[1], for: .normal)
        }
    }
    
    // Q ELECTRIC
    func electricQuestion() {
        showPopUpBox()
        if let index = randomQuestions {
            lblQuestionsTitle.text = electricityQuestions[index].questions
            btnOption1.setTitle(electricityQuestions[index].answers[0], for: .normal)
            btnOption2.setTitle(electricityQuestions[index].answers[1], for: .normal)
        }
    }
    
    // Q SHOPPING BAG
    func shoppingBagQuestion() {
        showPopUpBox()
        if let index = randomQuestions {
            lblQuestionsTitle.text = shoppingBagQuestions[index].questions
            btnOption1.setTitle(shoppingBagQuestions[index].answers[0], for: .normal)
            btnOption2.setTitle(shoppingBagQuestions[index].answers[1], for: .normal)
        }
    }
    
    // Q KIPAS
    func kipasQuestion() {
        showPopUpBox()
        if let index = randomQuestions {
            lblQuestionsTitle.text = kipasQuestions[index].questions
            btnOption1.setTitle(kipasQuestions[index].answers[0], for: .normal)
            btnOption2.setTitle(kipasQuestions[index].answers[1], for: .normal)
        }
    }
    
    // FOOD FACT
    func foodFact() {
        hideQuestionsShowFact()
        if let index = randomQuestions {
            factImage.image = UIImage(named: FoodQuestions[index].imageName)
            lblFactTitle.text = FoodQuestions[index].factTitle
            lblFactBody.text = FoodQuestions[index].factBody
            lblTapToDismiss.alpha = 1
            lblFactBody.adjustsFontSizeToFitWidth = true
            lblFactBody.numberOfLines = 0
        }
        addTapGesture()
    }
    
    // ELECTRIC FACT
    func electricFact() {
        hideQuestionsShowFact()
        if let index = randomQuestions {
            factImage.image = UIImage(named: electricityQuestions[index].imageName)
            lblFactTitle.text = electricityQuestions[index].factTitle
            lblFactBody.text = electricityQuestions[index].factBody
            lblTapToDismiss.alpha = 1
            lblFactBody.adjustsFontSizeToFitWidth = true
            lblFactBody.numberOfLines = 0
        }
        addTapGesture()
    }
    
    // SHOPPING BAG FACT
    func shoppingBagFact() {
        hideQuestionsShowFact()
        if let index = randomQuestions {
            factImage.image = UIImage(named: shoppingBagQuestions[index].imageName)
            lblFactTitle.text = shoppingBagQuestions[index].factTitle
            lblFactBody.text = shoppingBagQuestions[index].factBody
            lblTapToDismiss.alpha = 1
            lblFactBody.adjustsFontSizeToFitWidth = true
            lblFactBody.numberOfLines = 0
        }
        addTapGesture()
    }
    
    // KIPAS BAG FACT
    func kipasFact() {
        hideQuestionsShowFact()
        if let index = randomQuestions {
            factImage.image = UIImage(named: kipasQuestions[index].imageName)
            lblFactTitle.text = kipasQuestions[index].factTitle
            lblFactBody.text = kipasQuestions[index].factBody
            lblTapToDismiss.alpha = 1
            lblFactBody.adjustsFontSizeToFitWidth = true
            lblFactBody.numberOfLines = 0
        }
        addTapGesture()
    }
    
    func animateButtonKePantai() {
        buttonKePantai.transform = CGAffineTransform(translationX: 100, y: 0)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.buttonKePantai.transform = .identity
        })
    }
    
    func hideButtonKePantai() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.buttonKePantai.transform = CGAffineTransform(translationX: 100, y: 0)
        })
    }
}

// MARK: - Perubahan UI

extension RumahViewController {
    
    private func perubahanPagi() {
        //panggil function ini buat perubahan background waktu pagi
        filter.backgroundColor = UIColor.white.withAlphaComponent(0)
        lampu.image = UIImage(named: "asset.LampuMati")
        jendela.image = UIImage(named: "asset.JendelaPagi")
        
        tandaSeru2.isHidden = false
        tandaSeru.isHidden = false
        tandaSeruShoppingBag.isHidden = false
        tandaSeruKipas.isHidden = false
        
        checkListrik()
        checkMakanan()
        checkKipas()
        checkShoppingBag()
    }
    
    private func perubahanSore() {
        //panggil function ini buat perubahan background waktu sore
        filter.gradientSore(view: filter)
        jendela.image = UIImage(named: "asset.JendelaSore")
        tandaSeru.isHidden = false
        
        checkListrik()
        checkMakanan()
        checkKipas()
        checkShoppingBag()
    }
    
    private func perubahanMalam() {
        //panggil function ini buat perubahan background waktu malam
        filter.gradientMalam(view: filter)
        jendela.image = UIImage(named: "asset.JendelaMalam")
        tandaSeru.isHidden = false
        
        checkListrik()
        checkMakanan()
        checkKipas()
        checkShoppingBag()
    }
    
    private func checkListrik() {
        guard let lastTappedListrik = UserDefaults.standard.object(forKey: "last_tappedListrik") as? Date else { return }
        print("Last tapped Listrik      : \(lastTappedListrik.description(with: .current))")
        
        let comparison = Calendar.current.compare(lastTappedListrik, to: Date(), toGranularity: .day)
        
        if comparison == .orderedSame {
            tandaSeru2.isHidden = true
        }
    }
    
    private func checkKipas() {
        guard let lastTappedKipas = UserDefaults.standard.object(forKey: "last_tappedKipas") as? Date else { return }
        print("Last tapped Kipas        : \(lastTappedKipas.description(with: .current))")
                
        let comparison = Calendar.current.compare(lastTappedKipas, to: Date(), toGranularity: .day)
        
        if comparison == .orderedSame {
            tandaSeruKipas.isHidden = true
        }
    }
    
    private func checkShoppingBag() {
        guard let lastTappedShoppingBag = UserDefaults.standard.object(forKey: "last_tappedShoppingBag") as? Date else { return }
        print("Last tapped Shopping bag : \(lastTappedShoppingBag.description(with: .current))\n")
        
        let comparison = Calendar.current.compare(lastTappedShoppingBag, to: Date(), toGranularity: .day)
        
        if comparison == .orderedSame {
            tandaSeruShoppingBag.isHidden = true
        }
    }
    
    private func checkMakanan() {
        guard let lastTappedMakanan = UserDefaults.standard.object(forKey: "last_tappedMakanan") as? Date else { return }
        
        print("Last tapped Makanan      : \(lastTappedMakanan.description(with: .current))")
        
        // Check beda segmen ato ga
        // check last tapped makanan itu beda segmen sama segmen sekarang
        
        if isMorning() {
            let sixToday = Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: Date())!
            let fifteenToday = Calendar.current.date(bySettingHour: 14, minute: 59, second: 59, of: Date())!
            
            if lastTappedMakanan >= sixToday && lastTappedMakanan <= fifteenToday {
                print("Last Tapped Makanan Time is between 6.00 - 14.59")
                tandaSeru.isHidden = true
            } else {
                tandaSeru.isHidden = false
            }
        } else if isAfternoon() {
            let fifteenToday = Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date())!
            let eighteenToday = Calendar.current.date(bySettingHour: 17, minute: 59, second: 59, of: Date())!
            
            //       28 jam 3    >= 29 jam 15          28 jam  3      <=  29 jam 18
            if lastTappedMakanan >= fifteenToday && lastTappedMakanan <= eighteenToday {
                print("Last Tapped Makanan Time is between 15.00 - 17.59")
                tandaSeru.isHidden = true
            } else {
                tandaSeru.isHidden = false
            }
        } else {
            let eighteenToday = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!
            
            if lastTappedMakanan >= eighteenToday  {
                print("Last Tapped Makanan Time is between 18.00 - 5:59")
                tandaSeru.isHidden = true
            } else {
                tandaSeru.isHidden = false
            }
        }
    }
    
    private func checkTimeOfDay() {
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
}

//MARK: - Transition
extension RumahViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .dismiss)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 3, animationType: .present)
    }
}

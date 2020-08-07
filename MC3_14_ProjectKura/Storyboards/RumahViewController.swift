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
    @IBOutlet weak var viewQuestions: UIView!
    @IBOutlet weak var viewFact: UIView!
    @IBOutlet weak var viewFactBody: UIView!
    
    
    @IBOutlet weak var factImage: UIImageView!
    @IBOutlet weak var lblQuestionsTitle: UILabel!
    @IBOutlet weak var lblFactTitle: UILabel!
    @IBOutlet weak var lblFactBody: UILabel!
    
    // Button
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnToFactBody: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnGotIt: UIButton!
    
    @IBOutlet weak var popUpBox: UIImageView!
    @IBOutlet weak var stackButtonOptions: UIStackView!
    @IBOutlet weak var buttonKePantai: UIButton!
    @IBOutlet var kura: UIImageView!
    @IBOutlet var factLabel: UILabel!
    @IBOutlet var factConstraint: NSLayoutConstraint!
    @IBOutlet var factWidthConstraint: NSLayoutConstraint!
    @IBOutlet var highlightDiary: UIImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // notif center property
    let date = Date()
    var dateComponents = DateComponents()
    var randomQuestions: Int?
    var factType: FactType?
    var isAnimating = false
    
    enum FactType {
        case food
        case electric
        case shoppingBag
        case kipas
    }
    
    let audioPlayer = AudioPlayer(filename: "after-the-rain", extension: "wav")
    
    // MARK: - Lifecycle
    
    // 1. view did load -- udh ngeload smua view ke memori tapi blm ditampilin
    // 2. view will apper -- proses nampilin view ke layar
    // 3. view did appear -- smua view udh ada di layar
    // 4. view will dissapear -- view otw ngilang
    // 5. view did dissabpear -- view udh ngilang
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Gallery.configureInitialState(toContext: getViewContext())
        initialViewAlpha()

        audioPlayer.setupAudioService()
        audioPlayer.playSound(withVolume: 1.0)
        transitioningDelegate = self
        buttonKePantai.transform = CGAffineTransform(translationX: 100, y: 0)
        
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(checkBackgroundBySeconds), userInfo: nil, repeats: true)
        
        let scores = Score.fetchAll(fromContext: getViewContext())
        print("\nCore data contents:")
        for (i, score) in scores.enumerated() {
            print("\(i+1). Score: \(score.score)  | Date: \(score.date?.description(with: .current) ?? "")")
        }
        print("")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(randomFact))
        kura.isUserInteractionEnabled = true
        kura.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector:#selector(checkBackgroundBySeconds), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
    }

    @objc func checkBackgroundBySeconds () {
        checkTimeOfDay()
        setupBackgroundByScore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTimeOfDay()
         setupBackgroundByScore()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideButtonKePantai()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButtonKePantai()
    }
    
    // MARK: - IBActions
    
    @IBAction func openDiary(_ sender: UIButton) {
        highlightDiary.alpha = 0
        highlightDiary.layer.removeAllAnimations()
        
        UIView.transition(with: kura, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.kura.image = UIImage(named: "asset.KuraDudukNormal")
        }, completion: nil)
        
        factConstraint.constant = -380
        constraintAnimation(initial: false)
        view.gestureRecognizers?.removeAll()
        
        let rumahStoryboard = UIStoryboard(name: "Rumah", bundle: nil)
        guard let destinationVC = rumahStoryboard.instantiateViewController(identifier: "DiaryViewController") as? DiaryViewController else { return }
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC, animated: true, completion: nil)
    }
    
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
        
        switch factType {
        case .food:
            checkAnswer(forSelectedButton: 0, type: .food)
            UserDefaults.standard.set(Date(), forKey: "last_tappedMakanan")
            foodFact()
        case .electric:
            checkAnswer(forSelectedButton: 0, type: .electric)
            UserDefaults.standard.set(Date(), forKey: "last_tappedListrik")
            electricFact()
        case .shoppingBag:
            checkAnswer(forSelectedButton: 0, type: .shoppingBag)
            UserDefaults.standard.set(Date(), forKey: "last_tappedShoppingBag")
            shoppingBagFact()
        case .kipas:
            checkAnswer(forSelectedButton: 0, type: .kipas)
            UserDefaults.standard.set(Date(), forKey: "last_tappedKipas")
            kipasFact()
        default:
            return
        }
    }
    
    @IBAction func btn2(_ sender: Any) {
        switch factType {
        case .food:
            checkAnswer(forSelectedButton: 0, type: .food)
            UserDefaults.standard.set(Date(), forKey: "last_tappedMakanan")
            foodFact()
        case .electric:
            checkAnswer(forSelectedButton: 0, type: .electric)
            UserDefaults.standard.set(Date(), forKey: "last_tappedListrik")
            electricFact()
        case .shoppingBag:
            checkAnswer(forSelectedButton: 0, type: .shoppingBag)
            UserDefaults.standard.set(Date(), forKey: "last_tappedShoppingBag")
            shoppingBagFact()
        case .kipas:
            checkAnswer(forSelectedButton: 0, type: .kipas)
            UserDefaults.standard.set(Date(), forKey: "last_tappedKipas")
            kipasFact()
        default:
            return
        }
    }
    
    @IBAction func kePantai(_ sender: Any) {
        hideFact()
        audioPlayer.lowerSound()
        let rumahStoryboard = UIStoryboard(name: "Pantai", bundle: nil)
        guard let destinationVC = rumahStoryboard.instantiateViewController(identifier: "PantaiViewController") as? PantaiViewController else { return }
        destinationVC.modalPresentationStyle = .fullScreen
        destinationVC.delegate = self
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
        checkTimeOfDay()
    }
    
    // MARK: - Helper functions
    
    private func checkAnswer(forSelectedButton buttonIndex: Int, type: FactType) {
        if let index = randomQuestions {
            
            var correctIndex : Int
            
            switch type {
                case .food:
                    correctIndex = FoodQuestions[index].goodAnswer
                case .electric:
                    correctIndex = electricityQuestions[index].goodAnswer
                case .kipas:
                    correctIndex = kipasQuestions[index].goodAnswer
                case .shoppingBag:
                    correctIndex = shoppingBagQuestions[index].goodAnswer
            }
            
            if correctIndex == buttonIndex {
                print("Good Answer")
                // Insert to core data
                Score.add(toContext: getViewContext(), score: 1)
            } else {
                print("Bad Answer")
            }
        }
    }
    
    private func setupBackgroundByScore() {
        if let score = calculateFinalScore() {
            // Score not nil, saatnya update
            print("Final score: \(score)\n")
            animateHiglightDiary()
    
            // Update last updated date to today
            UserDefaults.standard.set(Date(), forKey: "last_updated")
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
        viewQuestions.isHidden = false
        viewFact.isHidden = true
        viewFactBody.isHidden = true
        lblQuestionsTitle.numberOfLines = 0
        lblQuestionsTitle.adjustsFontSizeToFitWidth = true
        
        UIView.transition(with: kura, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.kura.image = UIImage(named: "asset.KuraDudukNormal")
        }, completion: nil)
        
        factConstraint.constant = -380
        constraintAnimation(initial: false)
        view.gestureRecognizers?.removeAll()

        viewPopUpBox.alpha = 0
        viewPopUpBox.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3) {
            self.viewPopUpBox.transform = CGAffineTransform.identity
            self.backgroundDimmer.alpha = 0.5
            self.viewPopUpBox.alpha = 1
        }
    }
    
    @IBAction func btnGoToFactBody(_ sender: Any) {
        viewFact.isHidden = true
        switch factType {
        case .food:
            foodFactBody()
        case .electric:
            electricFactBody()
        case .shoppingBag:
            shoppingBagFactBody()
        case .kipas:
            kipasFactBody()
        default:
            return
        }
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        tapToDismiss()
    }
    
    @IBAction func btnGotIt(_ sender: Any) {
        tapToDismiss()
    }
    
    //
    @objc func randomFact() {
        UIView.transition(with: kura, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.kura.image = UIImage(named: "asset.KuraDudukNoleh")
        }, completion: nil)
        
        let index = Int.random(in: 0..<facts.count)
        factLabel.text = facts[index]
        
        let wordLength = facts[index].count
        
        if wordLength <= 100 {
            factWidthConstraint.constant = -70
        } else {
            factWidthConstraint.constant = 0
        }
        constraintAnimation(initial: false)
        
        if factConstraint.constant == 50 {
            typingAnimation(text: facts[index])
        }
        factConstraint.constant = 50
        constraintAnimation(initial: true)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeFactChatBox))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func closeFactChatBox() {
        hideFact()
    }
    
    func animateHiglightDiary() {
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.repeat, .autoreverse, .calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.highlightDiary.alpha = 1
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.highlightDiary.alpha = 0.5
            }
        }, completion: nil)
    }
    func hideFact() {
        if !isAnimating {
            view.gestureRecognizers?.removeAll()
            UIView.transition(with: kura, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.kura.image = UIImage(named: "asset.KuraDudukNormal")
            }, completion: nil)
            factConstraint.constant = -380
            constraintAnimation(initial: false)
        }
    }
    
    func typingAnimation(text: String) {
        kura.isUserInteractionEnabled = false
        view.gestureRecognizers?.removeAll()
        factLabel.text = ""
        for letter in text {
            
            factLabel.text?.append(letter)
            
            RunLoop.current.run(until: Date() + 0.02)
        }
        kura.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeFactChatBox))
        view.addGestureRecognizer(tap)
    }
    
    func constraintAnimation(initial: Bool) {
        if initial { isAnimating = true }
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            if initial { self.isAnimating = false }
        })
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
        viewQuestions.isHidden = true
        viewFact.isHidden = false
        if let index = randomQuestions {
            factImage.image = UIImage(named: FoodQuestions[index].imageName)
            lblFactTitle.text = FoodQuestions[index].factTitle
        }
    }
    
    func foodFactBody() {
        viewFactBody.isHidden = false
        if let index = randomQuestions {
            lblFactBody.text = FoodQuestions[index].factBody
            lblFactBody.adjustsFontSizeToFitWidth = true
            lblFactBody.numberOfLines = 0
        }
    }
    
    
    // ELECTRIC FACT
    func electricFact() {
        viewQuestions.isHidden = true
        viewFact.isHidden = false
        if let index = randomQuestions {
            factImage.image = UIImage(named: electricityQuestions[index].imageName)
            lblFactTitle.text = electricityQuestions[index].factTitle
        }
    }
    
    func electricFactBody() {
        viewFactBody.isHidden = false
        if let index = randomQuestions {
            lblFactBody.text = electricityQuestions[index].factBody
            lblFactBody.adjustsFontSizeToFitWidth = true
            lblFactBody.numberOfLines = 0
        }
    }
    
    // SHOPPING BAG FACT
    func shoppingBagFact() {
        viewQuestions.isHidden = true
        viewFact.isHidden = false
        if let index = randomQuestions {
            factImage.image = UIImage(named: shoppingBagQuestions[index].imageName)
            lblFactTitle.text = shoppingBagQuestions[index].factTitle
        }
    }
    
    func shoppingBagFactBody() {
        viewFactBody.isHidden = false
        if let index = randomQuestions {
            lblFactBody.text = shoppingBagQuestions[index].factBody
            lblFactBody.adjustsFontSizeToFitWidth = true
            lblFactBody.numberOfLines = 0
        }
    }
    
    // KIPAS BAG FACT
    func kipasFact() {
        viewQuestions.isHidden = true
        viewFact.isHidden = false
        if let index = randomQuestions {
            factImage.image = UIImage(named: kipasQuestions[index].imageName)
            lblFactTitle.text = kipasQuestions[index].factTitle
        }
    }
    
    func kipasFactBody() {
        viewFactBody.isHidden = false
        if let index = randomQuestions {
            lblFactBody.text = kipasQuestions[index].factBody
            lblFactBody.adjustsFontSizeToFitWidth = true
            lblFactBody.numberOfLines = 0
        }
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
        checkKipas()
        checkShoppingBag()
        checkMakanan()
    }
    
    private func perubahanSore() {
        //panggil function ini buat perubahan background waktu sore
        filter.gradientSore(view: filter)
        lampu.image = UIImage(named: "asset.LampuNyalaMalam")
        jendela.image = UIImage(named: "asset.JendelaSore")
        tandaSeru.isHidden = false
        
        checkListrik()
        checkKipas()
        checkShoppingBag()
        checkMakanan()
    }
    
    private func perubahanMalam() {
        //panggil function ini buat perubahan background waktu malam
        filter.gradientMalam(view: filter)
        lampu.image = UIImage(named: "asset.LampuNyalaMalam")
        jendela.image = UIImage(named: "asset.JendelaMalam")
        tandaSeru.isHidden = false
        
        checkListrik()
        checkKipas()
        checkShoppingBag()
        checkMakanan()
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
        print("Last tapped Shopping bag : \(lastTappedShoppingBag.description(with: .current))")
        
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
                print("Last Tapped Makanan Time is between 6.00 - 14.59\n")
                tandaSeru.isHidden = true
            } else {
                tandaSeru.isHidden = false
            }
        } else if isAfternoon() {
            let fifteenToday = Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date())!
            let eighteenToday = Calendar.current.date(bySettingHour: 17, minute: 59, second: 59, of: Date())!
            
            //       28 jam 3    >= 29 jam 15          28 jam  3      <=  29 jam 18
            if lastTappedMakanan >= fifteenToday && lastTappedMakanan <= eighteenToday {
                print("Last Tapped Makanan Time is between 15.00 - 17.59\n")
                tandaSeru.isHidden = true
            } else {
                tandaSeru.isHidden = false
            }
        } else {
            let eighteenToday = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            let eighteenYesterday = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: yesterday)!
            let zeroToday = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
            let sixToday = Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: Date())!

            if Date() >= zeroToday && Date() < sixToday {
                if lastTappedMakanan >= eighteenYesterday && lastTappedMakanan < sixToday {
                    tandaSeru.isHidden = true
                } else {
                    tandaSeru.isHidden = false
                }
            } else {
                if lastTappedMakanan >= eighteenToday {
                    print("Last Tapped Makanan Time is between 18.00 - 5:59\n")
                    tandaSeru.isHidden = true
                } else {
                    tandaSeru.isHidden = false
                }
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

// MARK: - Pantai View Controller Delegate
extension RumahViewController: PantaiViewControllerDelegate {
    
    func pantaiWillDismiss() {
        audioPlayer.playSound(withVolume: 1.0)
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

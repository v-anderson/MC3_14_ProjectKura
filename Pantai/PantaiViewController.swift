//
//  PantaiViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Vincent Anderson Ngadiman on 21/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

protocol PantaiViewControllerDelegate: class {
    func pantaiWillDismiss()
}

class PantaiViewController: UIViewController {

    @IBOutlet weak var firstWave: UIImageView!
    @IBOutlet weak var secondWave: UIImageView!
    
    @IBOutlet weak var jellyFish: UIImageView!
    @IBOutlet weak var smallJellyFish: UIImageView!
    
    @IBOutlet weak var firstOrangeFish: UIImageView!
    @IBOutlet weak var firstGrayFish: UIImageView!
    @IBOutlet weak var secondOrangeFish: UIImageView!
    @IBOutlet weak var secondGrayFish: UIImageView!
    
    @IBOutlet weak var popUpPapan: UIImageView!
    @IBOutlet weak var fishShadow: UIImageView!
    @IBOutlet weak var fishShadow2: UIImageView!
    @IBOutlet weak var fishShadow3: UIImageView!
    @IBOutlet weak var fishShadow4: UIImageView!
    @IBOutlet weak var fishShadow5: UIImageView!
    @IBOutlet weak var fishShadow6: UIImageView!
    @IBOutlet weak var fishShadow7: UIImageView!
    @IBOutlet weak var pantaiBG: UIImageView!
    @IBOutlet weak var koral: UIImageView!
    @IBOutlet weak var buttonKeRumah: UIButton!
    @IBOutlet weak var papan: UIImageView!
    
    @IBOutlet weak var filterGelap: UIView!
    private let daysLeftLabel = UILabel()
    private let daysLabel = UILabel()
    
    let audioPlayer = AudioPlayer(filename: "beach-waves", extension: "wav")
    
    weak var timer: Timer!
    weak var delegate: PantaiViewControllerDelegate?
    
    var isDarkStatusBar = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDarkStatusBar ? .lightContent : .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterGelap.isHidden = true
        popUpPapan.isHidden = true
        papan.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(papanTapped)))
        papan.isUserInteractionEnabled = true
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAnywhereToDismiss)))
        view.isUserInteractionEnabled = true
        
        audioPlayer.setupAudioService()
        createLabelPapan()
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(checkBackgroundBySeconds), userInfo: nil, repeats: true)
        buttonKeRumah.transform = CGAffineTransform(translationX: -100, y: 0)
        transitioningDelegate = self
        
        NotificationCenter.default.addObserver(self, selector:#selector(checkBackgroundBySeconds), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("Timer invalidated, observers removed")
    }
    
    @objc func checkBackgroundBySeconds () {
        setupBackgroundByScore()
        configurePapan()
    }
    
    @objc func papanTapped() {
        filterGelap.isHidden = false
        popUpPapan.isHidden = false
        filterGelap.alpha = 0
        popUpPapan.transform = CGAffineTransform(scaleX: 0, y: 0)
        createLabelPapanPopUp()
        UIView.animate(withDuration: 0.3) {
            self.popUpPapan.transform = CGAffineTransform.identity
            self.filterGelap.alpha = 0.6
        }
    }
    
    @objc func tapAnywhereToDismiss() {
        
        popUpPapan.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpPapan.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.filterGelap.alpha = 0
        }) { (_) in
            self.filterGelap.isHidden = true
            self.popUpPapan.isHidden = true
        }
        
        
//        UIView.animate(withDuration: 0.3) {
//            self.filterGelap.alpha = 0
//            self.popUpPapan.transform = CGAffineTransform(scaleX: 0, y: 0)
//            self.filterGelap.isHidden = true
//            self.popUpPapan.isHidden = true
//            
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        audioPlayer.playSound(withVolume: 0.5)
        loadAnimation()

        let scores = Score.fetchAll(fromContext: getViewContext())
        print("\nCore data contents:")
        for (i, score) in scores.enumerated() {
            print("\(i+1). Score: \(score.score)  | Date: \(score.date?.description(with: .current) ?? "")")
        }
        print("")
        
        setupBackgroundByScore()
        configurePapan()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.stopSound()
        hideButtonKeRumah()
        timer.invalidate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButtonKeRumah()
    }
    
    @IBAction func keRumah(_ sender: Any) {
        delegate?.pantaiWillDismiss()
        dismiss(animated: true, completion: nil)
    }
    
    /// Update background according current time
    private func updateBackgroundWith (score: Int) {
        if isMorning() {
            isDarkStatusBar = false
            if score < 4 {
                pagiKotorBanget()
            } else if score < 8 {
                pagiKotor()
            } else if score < 12 {
                pagiNetral()
            } else { pagiBersih() }
        } else if isAfternoon() {
            isDarkStatusBar = false
            if score < 4 {
                soreKotorBanget()
            } else if score < 8 {
                soreKotor()
            } else if score < 12 {
                soreNetral()
            } else { soreBersih() }
        } else {
            isDarkStatusBar = true
            if score < 4 {
                malemKotorBanget()
            } else if score < 8 {
                malemKotor()
            } else if score < 12 {
                malemNetral()
            } else { malemBersih() }
        }
    }
    
    private func setupBackgroundByScore() {
        if let score = calculateFinalScore() {
            // Score not nil, saatnya update
            print("Final score: \(score)\n")
            
            //cek masuk kategori mana
            updateBackgroundWith(score: score)
            
            // Update last updated date to today
            UserDefaults.standard.set(Date(), forKey: "last_updated")
        } else {
            // Belom saatnya update, pake score dari user defaults
            guard let lastScore = UserDefaults.standard.object(forKey: "last_score") as? Int else { return }
            print("Last score: \(lastScore)\n")
            
            updateBackgroundWith(score: lastScore)
        }
    }
    
    private func createLabelPapanPopUp() {
            
            let headingPopUp = UILabel()
            
            headingPopUp.translatesAutoresizingMaskIntoConstraints = false
            headingPopUp.text = "Beach changing in:"
            headingPopUp.textAlignment = .center
            headingPopUp.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
            headingPopUp.font = UIFont(name: "Rubik-Medium", size: 18)
        
            let daysLeftLabel2 = UILabel()
            
            daysLeftLabel2.translatesAutoresizingMaskIntoConstraints = false
            daysLeftLabel2.text = daysLeftLabel.text
            daysLeftLabel2.textAlignment = .center
            daysLeftLabel2.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
            daysLeftLabel2.font = UIFont(name: "Rubik-Bold", size: 70)
        
            
            let moreLabel = UILabel()
            moreLabel.translatesAutoresizingMaskIntoConstraints = false
            moreLabel.text = "more"
            moreLabel.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
            moreLabel.font = UIFont(name: "Rubik-Medium", size: 36)
            
            let daysLabel2 = UILabel()
            daysLabel2.translatesAutoresizingMaskIntoConstraints = false
            daysLabel2.text = "days"
            daysLabel2.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
            daysLabel2.font = UIFont(name: "Rubik-Medium", size: 36)
            
            let verticalStack = UIStackView(arrangedSubviews: [moreLabel, daysLabel2])
            verticalStack.translatesAutoresizingMaskIntoConstraints = false
            verticalStack.axis = .vertical
            verticalStack.spacing = -3
            
            popUpPapan.addSubview(daysLeftLabel2)
            popUpPapan.addSubview(headingPopUp)
            popUpPapan.addSubview(verticalStack)
            
        
            NSLayoutConstraint(item: daysLeftLabel2, attribute: .trailing, relatedBy: .equal, toItem: popUpPapan, attribute: .centerX, multiplier: 0.82, constant: 0).isActive = true
        NSLayoutConstraint(item: daysLeftLabel2, attribute: .centerY, relatedBy: .equal, toItem: popUpPapan, attribute: .centerY, multiplier: 1.1, constant: 0).isActive = true
            NSLayoutConstraint(item: verticalStack, attribute: .leading, relatedBy: .equal, toItem: popUpPapan, attribute: .centerX, multiplier: 0.9, constant: 0).isActive = true
            
            NSLayoutConstraint.activate([
                verticalStack.topAnchor.constraint(equalTo: daysLeftLabel2.topAnchor, constant: 2),
                headingPopUp.centerXAnchor.constraint(equalTo: popUpPapan.centerXAnchor),
                headingPopUp.bottomAnchor.constraint(equalTo: daysLeftLabel2.topAnchor, constant: 8)
                
            ])
        }
    
    private func createLabelPapan() {
        daysLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLeftLabel.text = ""
        daysLeftLabel.textAlignment = .center
        daysLeftLabel.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
        daysLeftLabel.font = UIFont(name: "Rubik-Bold", size: 22)
        
        let moreLabel = UILabel()
        moreLabel.translatesAutoresizingMaskIntoConstraints = false
        moreLabel.text = "more"
        moreLabel.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
        moreLabel.font = UIFont(name: "Rubik-Medium", size: 9)
        
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        daysLabel.text = "days"
        daysLabel.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
        daysLabel.font = UIFont(name: "Rubik-Medium", size: 10)
        
        let verticalStack = UIStackView(arrangedSubviews: [moreLabel, daysLabel])
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.spacing = -3
        
//        let descriptionLabel = UILabel()
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        descriptionLabel.text = "Until the beach changes"
//        descriptionLabel.textColor = UIColor(red: 123/255, green: 71/255, blue: 23/255, alpha: 1)
//        descriptionLabel.font = UIFont(name: "Rubik-Regular", size: 5)
        
        papan.addSubview(daysLeftLabel)
        papan.addSubview(verticalStack)
//        papan.addSubview(descriptionLabel)
        
        NSLayoutConstraint(item: daysLeftLabel, attribute: .trailing, relatedBy: .equal, toItem: papan, attribute: .centerX, multiplier: 0.82, constant: 0).isActive = true
        NSLayoutConstraint(item: daysLeftLabel, attribute: .centerY, relatedBy: .equal, toItem: papan, attribute: .centerY, multiplier: 0.73, constant: 0).isActive = true
        NSLayoutConstraint(item: verticalStack, attribute: .leading, relatedBy: .equal, toItem: papan, attribute: .centerX, multiplier: 0.9, constant: 0).isActive = true
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: daysLeftLabel.topAnchor, constant: 2),
//
//            descriptionLabel.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 2),
//            descriptionLabel.centerXAnchor.constraint(equalTo: papan.centerXAnchor, constant: 1)
        ])
    }
    
    private func configurePapan() {
        guard let lastUpdated = UserDefaults.standard.object(forKey: "last_updated") as? Date else { return }

        let lastUpdateDate = Calendar.current.startOfDay(for: lastUpdated)
        let daysSinceLastUpdate = Date.daysAfter(date: lastUpdateDate)
        
        switch daysSinceLastUpdate {
        case 0:
            daysLeftLabel.text = "3"
            daysLabel.text = "days"
        case 1:
            daysLeftLabel.text = "2"
            daysLabel.text = "days"
        case 2:
            daysLeftLabel.text = "1"
            daysLabel.text = "day"
        default:
            daysLeftLabel.text = "3"
            daysLabel.text = "days"
        }
    }
}

// MARK: Perubahan Environment
extension PantaiViewController {
    private func pagiNetral() {
        firstWave.image = UIImage(named: "Laut Belakang Pagi Netral")
        secondWave.image = UIImage(named: "Laut Depan Pagi Netral")
        pantaiBG.image = UIImage(named: "Island Pagi Netral")
        koral.image = UIImage(named: "Bawah laut Pagi Bersih")
        ikanBayanganMuncul()
        ikanWarnaHidden()
    }
    
    private func pagiKotor() {
        firstWave.image = UIImage(named: "Laut Belakang Pagi Kotor")
        secondWave.image = UIImage(named: "Laut Depan Pagi Kotor")
        pantaiBG.image = UIImage(named: "Island Pagi Kotor")
        koral.image = UIImage(named: "Dasar Laut Pagi Kotor")
        ikanHilang()
    }
    
    
    private func pagiBersih() {
        firstWave.image = UIImage(named: "Laut Pagi Bersih")
        secondWave.image = UIImage(named: "Laut Depan Pagi Bersih")
        pantaiBG.image = UIImage(named: "Island Pagi Bersih")
        koral.image = UIImage(named: "Bawah laut Pagi Bersih")
        ikanMuncul()
    }
    
    private func pagiKotorBanget() {
        firstWave.image = UIImage(named: "Laut Belakang Pagi Kotor Banget")
        secondWave.image = UIImage(named: "Laut Depan Pagi Kotor Banget")
        pantaiBG.image = UIImage(named: "Island Pagi Kotor Banget")
        koral.image = UIImage(named: "Dasar Laut Kotor Banget")
        ikanHilang()
    }
    
    
    private func malemNetral() {
        firstWave.image = UIImage(named: "Laut Belakang Malem Netral")
        secondWave.image = UIImage(named: "Laut Depan Malem Netral")
        pantaiBG.image = UIImage(named: "Island Malem Netral")
        ikanBayanganMuncul()
        ikanWarnaHidden()
        koral.image = UIImage(named: "Bawah laut Pagi Bersih")
    }
    
    private func malemBersih() {
        firstWave.image = UIImage(named: "Laut Malem Bersih")
        secondWave.image = UIImage(named: "Laut Ikan Malem Bersih")
        pantaiBG.image = UIImage(named: "Island Malem Bersih")
        koral.image = UIImage(named: "Bawah laut Pagi Bersih")
        ikanMuncul()
    }
    
    private func malemKotor() {
        firstWave.image = UIImage(named: "Laut Belakang Malem Kotor")
        secondWave.image = UIImage(named: "Laut Depan Malem Kotor")
        pantaiBG.image = UIImage(named: "Island Malem Kotor")
        koral.image = UIImage(named: "Dasar Laut Pagi Kotor")
        ikanHilang()
    }
    
    private func malemKotorBanget() {
        firstWave.image = UIImage(named: "Laut Belakang Malem Kotor Banget")
        secondWave.image = UIImage(named: "Laut Depan Malem Kotor Banget")
        pantaiBG.image = UIImage(named: "Island Malem Kotor Banget")
        koral.image = UIImage(named: "Dasar Laut Kotor Banget")
        ikanHilang()
    }
    
    private func soreNetral() {
        firstWave.image = UIImage(named: "Laut Belakang Sore Netral")
        secondWave.image = UIImage(named: "Laut Depan Sore Netral")
        pantaiBG.image = UIImage(named: "Island Sore Netral")
        ikanBayanganMuncul()
        ikanWarnaHidden()
        koral.image = UIImage(named: "Bawah laut Pagi Bersih")
    }
    
    private func soreBersih() {
        firstWave.image = UIImage(named: "Laut Sore Bersih")
        secondWave.image = UIImage(named: "Laut Ikan Sore Bersih")
        pantaiBG.image = UIImage(named: "Island Sore Bersih")
        koral.image = UIImage(named: "Bawah laut Pagi Bersih")
        ikanMuncul()
    }
    
    private func soreKotor() {
        firstWave.image = UIImage(named: "Laut Belakang Sore Kotor")
        secondWave.image = UIImage(named: "Laut Depan Sore Kotor")
        pantaiBG.image = UIImage(named: "Island Sore Kotor")
        koral.image = UIImage(named: "Dasar Laut Pagi Kotor")
        ikanHilang()
    }
    
    private func soreKotorBanget() {
        firstWave.image = UIImage(named: "Laut Belakang Sore Kotor Banget")
        secondWave.image = UIImage(named: "Laut Depan Sore Kotor Banget")
        pantaiBG.image = UIImage(named: "Island Sore Kotor Banget")
        koral.image = UIImage(named: "Dasar Laut Kotor Banget")
        ikanHilang()
    }
}


// MARK: function ikan
extension PantaiViewController {
    private func ikanHilang() {
        jellyFish.isHidden = true
        smallJellyFish.isHidden = true
        firstOrangeFish.isHidden = true
        firstGrayFish.isHidden = true
        secondOrangeFish.isHidden = true
        secondGrayFish.isHidden = true
        fishShadow.isHidden = true
        fishShadow2.isHidden = true
        fishShadow3.isHidden = true
        fishShadow4.isHidden = true
        fishShadow5.isHidden = true
        fishShadow6.isHidden = true
        fishShadow7.isHidden = true
    }
    
    private func ikanMuncul() {
        loadAnimationFish()
        jellyFish.isHidden = false
        smallJellyFish.isHidden = false
        firstOrangeFish.isHidden = false
        firstGrayFish.isHidden = false
        secondOrangeFish.isHidden = false
        secondGrayFish.isHidden = false
        fishShadow.isHidden = false
        fishShadow2.isHidden = false
        fishShadow3.isHidden = false
        fishShadow4.isHidden = false
        fishShadow5.isHidden = false
        fishShadow6.isHidden = false
        fishShadow7.isHidden = false
    }
    
    private func ikanBayanganMuncul() {
        loadAnimationFish()
        fishShadow.isHidden = false
        fishShadow2.isHidden = false
        fishShadow3.isHidden = false
        fishShadow4.isHidden = false
        fishShadow5.isHidden = false
        fishShadow6.isHidden = false
        fishShadow7.isHidden = false
    }
    
    private func ikanWarnaHidden() {
        jellyFish.isHidden = true
        smallJellyFish.isHidden = true
        firstOrangeFish.isHidden = true
        firstGrayFish.isHidden = true
        secondOrangeFish.isHidden = true
        secondGrayFish.isHidden = true
    }
}


// MARK: Animation
extension PantaiViewController {
    private func loadAnimation() {
        
        UIView.animate(withDuration: 3, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.secondWave.transform = CGAffineTransform(translationX: -20, y: 10)
        })
        
        UIView.animate(withDuration: 4, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.firstWave.transform = CGAffineTransform(translationX: 20, y: -10)
        })
    }
    
    private func loadAnimationFish() {
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
    
    private func animateButtonKeRumah() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.buttonKeRumah.transform = .identity
        })
    }
    
    private func hideButtonKeRumah() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.buttonKeRumah.transform = CGAffineTransform(translationX: -100, y: 0)
        })
    }
}

// MARK: - Transitioning Delegate

extension PantaiViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1.5, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1.5, animationType: .dismiss)
    }
}

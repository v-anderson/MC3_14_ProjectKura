//
//  PantaiViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Vincent Anderson Ngadiman on 21/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class PantaiViewController: UIViewController {

    @IBOutlet weak var firstWave: UIImageView!
    @IBOutlet weak var secondWave: UIImageView!
    @IBOutlet weak var jellyFish: UIImageView!
    @IBOutlet weak var smallJellyFish: UIImageView!
    @IBOutlet weak var firstOrangeFish: UIImageView!
    @IBOutlet weak var firstGrayFish: UIImageView!
    @IBOutlet weak var secondOrangeFish: UIImageView!
    @IBOutlet weak var secondGrayFish: UIImageView!
    
    @IBOutlet weak var pantaiBG: UIImageView!
    
    @IBOutlet weak var koral: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAnimation()

        pagiKotorBanget()
    }
    
    
    func ikanHilang() {
        jellyFish.isHidden = true
        smallJellyFish.isHidden = true
        firstOrangeFish.isHidden = true
        firstGrayFish.isHidden = true
        secondOrangeFish.isHidden = true
        secondGrayFish.isHidden = true
    }
    
    func ikanMuncul() {
        jellyFish.isHidden = false
        smallJellyFish.isHidden = false
        firstOrangeFish.isHidden = false
        firstGrayFish.isHidden = false
        secondOrangeFish.isHidden = false
        secondGrayFish.isHidden = false
    }
    
    
    func pagiKotor() {
        firstWave.image = UIImage(named: "Laut Belakang Pagi Kotor")
        secondWave.image = UIImage(named: "Laut Depan Pagi Kotor")
        pantaiBG.image = UIImage(named: "Island Pagi Kotor")
        koral.image = UIImage(named: "Dasar Laut Pagi Kotor")
        ikanHilang()
    }
    
    
    func pagiBersih() {
        firstWave.image = UIImage(named: "Laut Pagi Bersih")
        secondWave.image = UIImage(named: "Laut Ikan Pagi Bersih")
        pantaiBG.image = UIImage(named: "Island Pagi Bersih")
        koral.image = UIImage(named: "Bawah laut Pagi Bersih")
        ikanMuncul()
    }
    
    func pagiKotorBanget() {
        firstWave.image = UIImage(named: "Laut Belakang Pagi Kotor Banget")
        secondWave.image = UIImage(named: "Laut Depan Pagi Kotor Banget")
        pantaiBG.image = UIImage(named: "Island Pagi Kotor Banget")
        koral.image = UIImage(named: "Dasar Laut Kotor Banget")
        ikanHilang()
    }
    
    
    func malemBersih() {
        firstWave.image = UIImage(named: "Laut Malem Bersih")
        secondWave.image = UIImage(named: "Laut Ikan Malem Bersih")
        pantaiBG.image = UIImage(named: "Island Malem Bersih")
        koral.image = UIImage(named: "Bawah laut Pagi Bersih")
        ikanMuncul()
    }
    
    func malemKotor() {
        firstWave.image = UIImage(named: "Laut Belakang Malem Kotor")
        secondWave.image = UIImage(named: "Laut Depan Malem Kotor")
        pantaiBG.image = UIImage(named: "Island Malem Kotor")
        koral.image = UIImage(named: "Dasar Laut Pagi Kotor")
        ikanHilang()
    }
    
    func malemKotorBanget() {
        firstWave.image = UIImage(named: "Laut Belakang Malem Kotor Banget")
        secondWave.image = UIImage(named: "Laut Depan Malem Kotor Banget")
        pantaiBG.image = UIImage(named: "Island Malem Kotor Banget")
        koral.image = UIImage(named: "Dasar Laut Kotor Banget")
        ikanHilang()
    }
    
    func soreBersih() {
        firstWave.image = UIImage(named: "Laut Sore Bersih")
        secondWave.image = UIImage(named: "Laut Ikan Sore Bersih")
        pantaiBG.image = UIImage(named: "Island Sore Bersih")
        koral.image = UIImage(named: "Bawah laut Pagi Bersih")
        ikanMuncul()
    }
    
    func soreKotor() {
        firstWave.image = UIImage(named: "Laut Belakang Sore Kotor")
        secondWave.image = UIImage(named: "Laut Depan Sore Kotor")
        pantaiBG.image = UIImage(named: "Island Sore Kotor")
        koral.image = UIImage(named: "Dasar Laut Pagi Kotor")
        ikanHilang()
    }
    
    func soreKotorBanget() {
        firstWave.image = UIImage(named: "Laut Belakang Sore Kotor Banget")
        secondWave.image = UIImage(named: "Laut Depan Sore Kotor Banget")
        pantaiBG.image = UIImage(named: "Island Sore Kotor Banget")
        koral.image = UIImage(named: "Dasar Laut Kotor Banget")
        ikanHilang()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let scores = Score.fetchAll(fromContext: getViewContext())
        scores.forEach { score in
            print(score.score, score.date)
        }
        
        setupBackgroundByScore()
    }
    
    private func setupBackgroundByScore() {
        if let score = calculateFinalScore() {
            // Score not nil, saatnya update
            print("Final score: \(score)")
            
            // Update last updated date to today
            UserDefaults.standard.set(Date(), forKey: "last_updated")
        } else {
            // Belom saatnya update, pake score dari user defaults
            let lastScore = UserDefaults.standard.object(forKey: "last_score")
            print("Last score: \(lastScore)")
            
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
        }, completion: nil)
    }
    


}

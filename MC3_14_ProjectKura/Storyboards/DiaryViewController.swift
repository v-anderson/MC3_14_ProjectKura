//
//  DiaryViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Vincent Anderson Ngadiman on 04/08/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {

    @IBOutlet weak var diaryImage: UIImageView!
    
    @IBOutlet weak var heartType: UIImageView!
    
    @IBOutlet weak var isiDiaryText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let maxContent = diaryContents[.redHeart]?.diaryImage.count else {return}
        
        let randomIndex = Int.random(in: 0...maxContent - 1)
        
        guard let score = getScore() else { return }
        print(score)
        
        guard let diaryRedHeart = diaryContents[.redHeart] else {return}
        
        guard let diaryBlueHeart = diaryContents[.blueHeart] else {return}
        
        guard let diaryYellowHeart = diaryContents[.yellowHeart] else {return}
       
        guard let diaryBlackHeart = diaryContents[.blackHeart] else {return}
        
        
        print(randomIndex)
        let platform = NSString()
        
        if score < 4 {
            diaryImage.image = UIImage(named: diaryBlackHeart.diaryImage[randomIndex])
            heartType.image = UIImage(named: "blackHeart")
            isiDiaryText.text = diaryBlackHeart.isiDiary[randomIndex]
        } else if score < 8 {
            diaryImage.image = UIImage(named: diaryYellowHeart.diaryImage[randomIndex])
            heartType.image = UIImage(named: "yellowHeart")
            isiDiaryText.text = diaryYellowHeart.isiDiary[randomIndex]
            
        } else if score < 12 {
            diaryImage.image = UIImage(named: diaryBlueHeart.diaryImage[randomIndex])
            heartType.image = UIImage(named: "blueHeart")
            isiDiaryText.text = diaryBlueHeart.isiDiary[randomIndex]
        } else {
            diaryImage.image = UIImage(named: diaryRedHeart.diaryImage[randomIndex])
            heartType.image = UIImage(named: "redHeart")
            isiDiaryText.text = diaryRedHeart.isiDiary[randomIndex]
        }
        
        isiDiaryText.adjustsFontForContentSizeCategory = true
    }
    

    private func getScore() -> Int? {
        if let score = calculateFinalScore() {
            // Score not nil, saatnya update
            print("Final score: \(score)\n")
            
            // Update last updated date to today
            UserDefaults.standard.set(Date(), forKey: "last_updated")
            
            return score
        } else {
            // Belom saatnya update, pake score dari user defaults
            guard let lastScore = UserDefaults.standard.object(forKey: "last_score") as? Int else { return nil}
            print("Last score: \(lastScore)\n")
            
            return lastScore
        }
    }

}

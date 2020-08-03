//
//  MainViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 30/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onboardingIfNeeded()
    }
    
    private func onboardingIfNeeded() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "has_launched_before")
        
        if !hasLaunchedBefore {
            // Show onboarding
            print("Launching onboarding")
            let onboardingStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let destinationVC = onboardingStoryboard.instantiateViewController(identifier: "LetterViewController")
            destinationVC.modalPresentationStyle = .fullScreen
            present(destinationVC, animated: true, completion: nil)
        }
        else {
            // Go straight to rumah
            let rumahStoryboard = UIStoryboard(name: "Rumah", bundle: nil)
            let destinationVC = rumahStoryboard.instantiateViewController(identifier: "RumahViewController")
            destinationVC.modalPresentationStyle = .fullScreen
            present(destinationVC, animated: true, completion: nil)
        }
    }
}

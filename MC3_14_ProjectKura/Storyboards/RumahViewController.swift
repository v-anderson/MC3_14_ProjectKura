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
    
    // notif center property
    let date = Date()
    var dateComponents = DateComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isMorning() {
            perubahanPagi()
        } else if isAfternoon() {
            perubahanSore()
        } else { perubahanMalam() }
        
    }
    
    //ini yang tombol tanda seru untuk munculin pertanyaan makanan
    @IBAction func tanyaMakanan(_ sender: Any) {
        
        tandaSeru.isHidden = true
    }
    
    
    //ini tombol tanda seru untuk munculin pertanyaan listrik
    @IBAction func tanyaListrik(_ sender: Any) {
        tandaSeru2.isHidden = true
        
    }
    
    private func perubahanPagi() {
        //panggil function ini buat perubahan background waktu pagi
        filter.backgroundColor = UIColor.white.withAlphaComponent(0)
        jendela.image = UIImage(named: "asset.JendelaPagi")
        tandaSeru.isHidden = false
    }
    
    private func perubahanSore() {
        //panggil function ini buat perubahan background waktu sore
        filter.gradientSore(view: filter)
        jendela.image = UIImage(named: "asset.JendelaSore")
        tandaSeru.isHidden = false
    }
    
    private func perubahanMalam() {
        //panggil function ini buat perubahan background waktu malam
        filter.gradientMalam(view: filter)
        jendela.image = UIImage(named: "asset.JendelaMalam")
        tandaSeru.isHidden = false
    }
}

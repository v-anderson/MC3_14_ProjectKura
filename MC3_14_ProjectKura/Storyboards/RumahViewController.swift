//
//  RumahViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Vincent Anderson Ngadiman on 20/07/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class RumahViewController: UIViewController {

    @IBOutlet weak var filter: UILabel!
    @IBOutlet weak var jendela: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perubahanPagi()

    }
    
    func perubahanPagi() {
        //panggil function ini buat perubahan background waktu pagi
        filter.backgroundColor = UIColor.white.withAlphaComponent(0)
        jendela.image = UIImage(named: "asset.JendelaPagi")
    }
    
    func perubahanSore() {
        //panggil function ini buat perubahan background waktu sore
        filter.gradientSore(view: filter)
        jendela.image = UIImage(named: "asset.JendelaSore")
    }
    
    func perubahanMalam() {
        //panggil function ini buat perubahan background waktu malam
        filter.gradientMalam(view: filter)
        jendela.image = UIImage(named: "asset.JendelaMalam")
    }
    
    


}

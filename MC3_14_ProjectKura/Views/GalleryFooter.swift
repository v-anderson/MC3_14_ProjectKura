//
//  FooterView.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 04/08/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class GalleryFooter: UICollectionReusableView {
        
    private let separator = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContents() {
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .darkGray
        
        addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

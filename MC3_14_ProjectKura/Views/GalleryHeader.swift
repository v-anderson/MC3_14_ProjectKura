//
//  GalleryHeader.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 04/08/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class GalleryHeader: UICollectionReusableView {
    
    private let titleLabel = UILabel()
    private let brushTitleImageView = UIImageView()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    private let brushHeartImageView = UIImageView()
    private let heartImageView = UIImageView()
    private let counterLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(withGallerySection gallerySection: GallerySection, inSection section: Int) {
        titleLabel.text = gallerySection.title
        brushTitleImageView.image = UIImage(named: gallerySection.brushImageName)
        counterLabel.text = gallerySection.count < 999 ? "\(gallerySection.count) x" : "999 x"
        
        if gallerySection.count == 0 {
            stackView.spacing = 16
            subtitleLabel.text = gallerySection.placeholder
        } else {
            stackView.spacing = 0
            subtitleLabel.text = nil
        }
        
        switch section {
        case 0:
            heartImageView.image = UIImage(named: "redHeart")
        case 1:
            heartImageView.image = UIImage(named: "blueHeart")
        case 2:
            heartImageView.image = UIImage(named: "yellowHeart")
        default:
            heartImageView.image = UIImage(named: "blackHeart")
        }
    }
    
    private func configureContents() {
        let containerView = UILabel()
        containerView.font = UIFont(name: "GloriaHallelujah", size: 16)
        containerView.text = " "
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(brushTitleImageView)
        containerView.addSubview(titleLabel)
        
        brushHeartImageView.translatesAutoresizingMaskIntoConstraints = false
        brushHeartImageView.image = UIImage(named: "brushHeart")
        
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.font = UIFont(name: "GloriaHallelujah", size: 16)

        brushHeartImageView.addSubview(heartImageView)
        brushHeartImageView.addSubview(counterLabel)
        
        let horizontalStack = UIStackView(arrangedSubviews: [containerView, brushHeartImageView])
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.distribution = .equalSpacing
                
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "GloriaHallelujah", size: 16)
        
        brushTitleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont(name: "GloriaHallelujah", size: 14)
        subtitleLabel.numberOfLines = 0
        
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(horizontalStack)
        stackView.addArrangedSubview(subtitleLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            brushTitleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -4),
            brushTitleImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 1),
            
            heartImageView.trailingAnchor.constraint(equalTo: brushHeartImageView.trailingAnchor, constant: -2),
            heartImageView.bottomAnchor.constraint(equalTo: brushHeartImageView.bottomAnchor),
            
            counterLabel.leadingAnchor.constraint(equalTo: brushHeartImageView.leadingAnchor, constant: 16),
            counterLabel.centerYAnchor.constraint(equalTo: brushHeartImageView.centerYAnchor, constant: -2),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}

//
//  GalleryViewController.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 04/08/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    let gallerySections = [
        GallerySection(title: "LOVELY MOMENTS", count: 1, galleries: [
            Gallery(image: "swimAllDay"),
            Gallery(image: "vitaminSea")
        ], placeholder: "Beautiful beach is Kura’s definition of perfect! Keep making the beach cleans and make Kura’s impressed."),
        
        GallerySection(title: "ONE FINE DAY(S)", count: 2, galleries: [
            Gallery(image: "refreshForAWhile"),
            Gallery(image: "relaxByTheBeach")
        ], placeholder: "Let’s make memories with Kura with a clean beach on the background!"),
        
        GallerySection(title: "SEA-RIOUS PROBLEMS", count: 0, galleries: [], placeholder: "Kura is proud of you. Because of you, Kura never see the sea in trouble!"),
        
        GallerySection(title: "SAD TRUTH", count: 1, galleries: [
            Gallery(image: "lossOfTheSea")
        ], placeholder: "You are the protector of the beach. There’s no way a trash can enter the beach as long you’re there!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
}

// MARK: - Collection View Data Source

extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gallerySections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallerySections[section].galleries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        
        cell.configure(with: gallerySections[indexPath.section].galleries[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GalleryHeader", for: indexPath) as! GalleryHeader
            
            let gallerySection = gallerySections[indexPath.section]
            header.configure(withTitle: gallerySection.title, count: gallerySection.count, placeholder: gallerySection.placeholder)
            
            return header
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "GalleryFooter", for: indexPath) as! GalleryFooter
            
            return footer
        }
    }
}

// MARK: - Collection View Delegate

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.5, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if gallerySections[section].count == 0 {
            return CGSize(width: view.frame.width, height: 140)
        } else {
            return CGSize(width: view.frame.width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 10)
    }
}

// MARK: - Configurations

extension GalleryViewController {
    
    private func configureCollectionView() {
        galleryCollectionView.showsVerticalScrollIndicator = false
        galleryCollectionView.register(GalleryHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GalleryHeader")
        galleryCollectionView.register(GalleryFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "GalleryFooter")
    }
}

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
    
    var galleryViewModel: GalleryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadData()
        transitioningDelegate = self
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func loadData() {
        let galleries = Gallery.fetchAll(fromContext: getViewContext())
        galleryViewModel = GalleryViewModel(withGalleries: galleries)
    }
}

// MARK: - Collection View Data Source

extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return galleryViewModel.gallerySections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryViewModel.gallerySections[section].galleries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        
        cell.configure(with: galleryViewModel.gallerySections[indexPath.section].galleries[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GalleryHeader", for: indexPath) as! GalleryHeader
            
            let gallerySection = galleryViewModel.gallerySections[indexPath.section]
            header.configure(withGallerySection: gallerySection, inSection: indexPath.section)
            
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
        
        if galleryViewModel.gallerySections[section].count == 0 {
            return CGSize(width: view.frame.width, height: 145)
        } else {
            return CGSize(width: view.frame.width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == galleryViewModel.gallerySections.count - 1 {
            return CGSize(width: view.frame.width, height: 0)
        } else {
            return CGSize(width: view.frame.width, height: 10)
        }
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

// MARK: - Transitioning Delegate

extension GalleryViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimation(animationDuration: 1, animationType: .dismiss)
    }
}

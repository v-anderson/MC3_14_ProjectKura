//
//  GalleryViewModel.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 05/08/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import Foundation

struct GalleryViewModel {
    
    let gallerySections: [GallerySection]
    
    init(withGalleries galleries: [Gallery]) {
        var sections: [GallerySection] = []
        
        print("Core data contents: ")
        galleries.forEach { (gallery) in
            print("id: \(gallery.id) | images: \(gallery.images ?? []) | count: \(gallery.count)")
            
            switch gallery.id {
            case 0:
                // RED HEART
                var galleries: [GalleryModel] = []
                
                guard let images = gallery.images else { break }
                
                for i in 0..<images.count {
                    if images[i] == 1 {
                        guard let imageName = diaryContents[.redHeart]?.diaryImage[i] else { break }
                        galleries.append(GalleryModel(image: imageName))
                    }
                }
                
                sections.append(
                    GallerySection(title: "LOVELY MOMENTS",
                                   brushImageName: "brushLovelyMoments",
                                   count: Int(gallery.count),
                                   galleries: galleries,
                                   placeholder: "Beautiful beach is Kura’s definition of perfect! Keep making the beach cleans and make Kura’s impressed."))
                
            case 1:
                // BLUE HEART
                var galleries: [GalleryModel] = []
                
                guard let images = gallery.images else { break }
                
                for i in 0..<images.count {
                    if images[i] == 1 {
                        guard let imageName = diaryContents[.blueHeart]?.diaryImage[i] else { break }
                        galleries.append(GalleryModel(image: imageName))
                    }
                }
                                
                sections.append(
                    GallerySection(title: "ONE FINE DAY",
                                   brushImageName: "brushOneFineDay",
                                   count: Int(gallery.count),
                                   galleries: galleries,
                                   placeholder: "Let’s make memories with Kura with a clean beach on the background!"))
                
            case 2:
                // YELLOW HEART
                var galleries: [GalleryModel] = []
                
                guard let images = gallery.images else { break }

                for i in 0..<images.count {
                    if images[i] == 1 {
                        guard let imageName = diaryContents[.yellowHeart]?.diaryImage[i] else { break }
                        galleries.append(GalleryModel(image: imageName))
                    }
                }
                
                sections.append(
                    GallerySection(title: "SEA-RIOUSLY BAD",
                                   brushImageName: "brushSeariouslyBad",
                                   count: Int(gallery.count),
                                   galleries: galleries,
                                   placeholder: "Kura is proud of you. Because of you, Kura never see the sea in trouble!"))
                
            default:
                // BLACK HEART
                var galleries: [GalleryModel] = []
                
                guard let images = gallery.images else { break }

                for i in 0..<images.count {
                    if images[i] == 1 {
                        guard let imageName = diaryContents[.blackHeart]?.diaryImage[i] else { break }
                        galleries.append(GalleryModel(image: imageName))
                    }
                }
                
                sections.append(
                    GallerySection(title: "SAD TRUTH",
                                   brushImageName: "brushSadTruth",
                                   count: Int(gallery.count),
                                   galleries: galleries,
                                   placeholder: "You are the protector of the beach. There’s no way a trash can enter the beach as long you’re there!"))
            }
        }
        print("")
        
        gallerySections = sections
    }
}

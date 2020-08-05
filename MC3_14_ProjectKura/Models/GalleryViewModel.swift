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
                var galleries: [GalleryModel] = []
                
                if gallery.images?[0] == 1 { galleries.append(GalleryModel(image: "swimAllDay")) }
                if gallery.images?[1] == 1 { galleries.append(GalleryModel(image: "vitaminSea")) }
                
                sections.append(
                    GallerySection(title: "LOVELY MOMENTS",
                                   brushImageName: "brushLovelyMoments",
                                   count: Int(gallery.count),
                                   galleries: galleries,
                                   placeholder: "Beautiful beach is Kura’s definition of perfect! Keep making the beach cleans and make Kura’s impressed."))
                
            case 1:
                var galleries: [GalleryModel] = []
                
                if gallery.images?[0] == 1 { galleries.append(GalleryModel(image: "refreshForAWhile")) }
                if gallery.images?[1] == 1 { galleries.append(GalleryModel(image: "relaxByTheBeach")) }
                
                sections.append(
                    GallerySection(title: "ONE FINE DAY",
                                   brushImageName: "brushOneFineDay",
                                   count: Int(gallery.count),
                                   galleries: galleries,
                                   placeholder: "Let’s make memories with Kura with a clean beach on the background!"))
                
            case 2:
                var galleries: [GalleryModel] = []
                
                if gallery.images?[0] == 1 { galleries.append(GalleryModel(image: "unexpectedNews")) }
                if gallery.images?[1] == 1 { galleries.append(GalleryModel(image: "shocked")) }
                
                sections.append(
                    GallerySection(title: "SEA-RIOUSLY BAD",
                                   brushImageName: "brushSeariouslyBad",
                                   count: Int(gallery.count),
                                   galleries: galleries,
                                   placeholder: "Kura is proud of you. Because of you, Kura never see the sea in trouble!"))
                
            default:
                var galleries: [GalleryModel] = []
                
                if gallery.images?[0] == 1 { galleries.append(GalleryModel(image: "lossOfTheSea")) }
                if gallery.images?[1] == 1 { galleries.append(GalleryModel(image: "nightmareAtTheBeach")) }
                
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

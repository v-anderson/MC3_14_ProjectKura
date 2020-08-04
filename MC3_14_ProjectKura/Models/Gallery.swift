//
//  Gallery.swift
//  MC3_14_ProjectKura
//
//  Created by Victor Samuel Cuaca on 04/08/20.
//  Copyright © 2020 Vincent Anderson Ngadiman. All rights reserved.
//

import Foundation

struct Gallery {
    let image: String
}

struct GallerySection {
    let title: String
    let count: Int
    let galleries: [Gallery]
    let placeholder: String
}

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

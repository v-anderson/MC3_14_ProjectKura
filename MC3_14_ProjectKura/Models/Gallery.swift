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
    let brushImageName: String
    let count: Int
    let galleries: [Gallery]
    let placeholder: String
}

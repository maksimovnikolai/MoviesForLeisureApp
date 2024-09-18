//
//  ImageCacheManager.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 18.09.2024.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}

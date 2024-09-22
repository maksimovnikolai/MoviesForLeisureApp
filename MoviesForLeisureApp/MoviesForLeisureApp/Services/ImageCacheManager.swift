//
//  ImageCacheManager.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 18.09.2024.
//

import UIKit

protocol ImageCacheManagerProtocol {
    func saveToCache(imageData: Data, forKey url: URL)
    func loadImageDataFromCache(from url: URL) -> Data?
}

final class ImageCacheManager1: ImageCacheManagerProtocol {
    private let cache = NSCache<NSString, UIImage>()
    
    func saveToCache(imageData: Data, forKey url: URL) {
        guard let image = UIImage(data: imageData) else { return }
        cache.setObject(image, forKey: url.deletingLastPathComponent().lastPathComponent as NSString)
    }
    
    func loadImageDataFromCache(from url: URL) -> Data? {
       let image = cache.object(forKey: url.deletingLastPathComponent().lastPathComponent as NSString)
        return image?.pngData()
    }
}

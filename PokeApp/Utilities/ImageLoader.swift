//
//  ImageLoader.swift
//  PokeApp
//
//  Created by marcenuk on 09/07/2019.
//  Copyright © 2019 marcenyuk. All rights reserved.
//

import UIKit

private class ImageCache {
    static let shared = NSCache<AnyObject, AnyObject>()
}

extension UIImageView {
    
    func setImage(from url: URL?) {
        self.image = nil
        guard let url = url else {
            return
        }
        
        if let imageFromCache = ImageCache.shared.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let response = data, error == nil {
                DispatchQueue.main.async {
                    guard let cachedImage = UIImage(data: response) else {
                        return
                    }
                    ImageCache.shared.setObject(cachedImage, forKey: url.absoluteString as AnyObject)
                    
                    self?.image = cachedImage
                }
            }
        }
        task.resume()
    }
}

//
//  UIImageExtensions.swift
//  PacelineDemo
//
//  Created by Jonathan  Fotland on 7/25/22.
//

import Foundation
import UIKit

var imageCache = URLCache.shared
extension UIImage {
    static func load(urlString: String, completion: @escaping (UIImage?) -> ()) {
        guard let imageURL = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: imageURL)
        
        if let cachedData = imageCache.cachedResponse(for: request) {
            let img = UIImage(data: cachedData.data)
            completion(img)
        } else {
            let urlSession = URLSession(configuration: .default).dataTask(with: imageURL) { (data, response, error) in
                if let error = error {
                    print("Error loading image: \(error)")
                    completion(nil)
                }
                
                if let data = data {
                    if let response = response {
                        let cache = CachedURLResponse(response: response, data: data)
                        imageCache.storeCachedResponse(cache, for: request)
                    }
                    let img = UIImage(data: data)
                    completion(img)
                }
            }
            
            urlSession.resume()
        }
    }
}

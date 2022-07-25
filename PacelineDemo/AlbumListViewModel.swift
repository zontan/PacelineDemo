//
//  AlbumListViewModel.swift
//  PacelineDemo
//
//  Created by Jonathan  Fotland on 7/25/22.
//

import Foundation

protocol AlbumListViewModelDelegate: NSObjectProtocol {
    func didFinishLoading()
    func loadingFailed(error: Error)
}

class AlbumListViewModel {
    //Normally this would be an environment variable, but we're demoing here.
    let dataURL = "https://paceline-public-danger-danger-danger.s3-us-west-2.amazonaws.com/iOS-Coding-Test-Itunes-100.json"
    
    var albumData: AlbumData?
    weak var delegate: AlbumListViewModelDelegate?
    
    init(delegate: AlbumListViewModelDelegate?) {
        self.delegate = delegate
        loadJSON(fromURLString: dataURL) { result in
            switch result {
            case .success(let data):
                do {
                    self.albumData = try JSONDecoder().decode(AlbumData.self, from: data)
                    self.delegate?.didFinishLoading()
                } catch(let error) {
                    self.delegate?.loadingFailed(error: error)
                }
            case .failure(let error):
                self.delegate?.loadingFailed(error: error)
            }
        }
    }
    
    private func loadJSON(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        } else {
            // TODO
        }
    }
    
    func numberOfAlbums() -> Int {
        if let albumData = albumData {
            return albumData.albums.count
        }
        return 0
    }
    
    func albumAtIndex(index: Int) -> Album? {
        if index < 0 { //This shouldn't ever happen, but no harm in sanity checking
            return nil
        }
        if let albumData = albumData {
            if albumData.albums.count > index {
                return albumData.albums[index]
            }
        }
        return nil
    }
}

//
//  AlbumDetailViewController.swift
//  PacelineDemo
//
//  Created by Jonathan  Fotland on 7/25/22.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    var album: Album?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        title = album?.name
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        UIImage.load(urlString: album?.imgURL ?? "") { image in
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        let titleHeader = UILabel()
        titleHeader.text = "Name"
        let titleLabel = UILabel()
        titleLabel.text = album?.name
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .right
        titleHeader.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleHeader)
        view.addSubview(titleLabel)
        
        titleHeader.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.firstBaselineAnchor.constraint(equalTo: titleHeader.firstBaselineAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleHeader.trailingAnchor, constant: 30).isActive = true
        
        let artistHeader = UILabel()
        artistHeader.text = "Artist"
        let artistLabel = UILabel()
        artistLabel.text = album?.artist
        artistLabel.numberOfLines = 0
        artistLabel.textAlignment = .right
        artistHeader.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistHeader)
        view.addSubview(artistLabel)
        
        artistHeader.leftAnchor.constraint(equalTo: titleHeader.leftAnchor).isActive = true
        artistLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        artistLabel.firstBaselineAnchor.constraint(equalTo: artistHeader.firstBaselineAnchor).isActive = true
        artistLabel.leadingAnchor.constraint(greaterThanOrEqualTo: artistHeader.trailingAnchor, constant: 30).isActive = true
        
        let genreHeader = UILabel()
        genreHeader.text = "Genre(s)"
        let genreLabel = UILabel()
        genreLabel.text = album?.genres.reduce("", { partialResult, genre in
            if let partial = partialResult {
                if partial == "" {
                    return genre.name
                } else {
                    return partial + ", \(genre.name)"
                }
            } else {
                return genre.name
            }
        })
        genreHeader.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(genreHeader)
        view.addSubview(genreLabel)
        
        genreHeader.leftAnchor.constraint(equalTo: artistHeader.leftAnchor).isActive = true
        genreLabel.rightAnchor.constraint(equalTo: artistLabel.rightAnchor).isActive = true
        genreLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 4).isActive = true
        genreLabel.firstBaselineAnchor.constraint(equalTo: genreHeader.firstBaselineAnchor).isActive = true
        
        let releaseHeader = UILabel()
        releaseHeader.text = "Release Date"
        let releaseLabel = UILabel()
        releaseLabel.text = album?.releaseDate
        
        releaseHeader.translatesAutoresizingMaskIntoConstraints = false
        releaseLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(releaseHeader)
        view.addSubview(releaseLabel)
        
        releaseHeader.leftAnchor.constraint(equalTo: genreHeader.leftAnchor).isActive = true
        releaseLabel.rightAnchor.constraint(equalTo: genreLabel.rightAnchor).isActive = true
        releaseLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 4).isActive = true
        releaseLabel.firstBaselineAnchor.constraint(equalTo: releaseHeader.firstBaselineAnchor).isActive = true
        
        let copyrightHeader = UILabel()
        copyrightHeader.text = "Copyright"
        let copyrightLabel = UILabel()
        copyrightLabel.text = album?.copyright
        copyrightLabel.numberOfLines = 0
        copyrightLabel.textAlignment = .right
        
        copyrightHeader.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(copyrightHeader)
        view.addSubview(copyrightLabel)
        
        copyrightHeader.leftAnchor.constraint(equalTo: releaseHeader.leftAnchor).isActive = true
        copyrightLabel.rightAnchor.constraint(equalTo: releaseLabel.rightAnchor).isActive = true
        copyrightLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: 4).isActive = true
        copyrightLabel.firstBaselineAnchor.constraint(equalTo: copyrightHeader.firstBaselineAnchor).isActive = true
        copyrightLabel.leadingAnchor.constraint(greaterThanOrEqualTo: copyrightHeader.trailingAnchor, constant: 30).isActive = true
        
        let iTunesButton = UIButton()
        iTunesButton.setTitle("View in iTunes", for: .normal)
        iTunesButton.setTitleColor(.black, for: .normal)
        iTunesButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iTunesButton)
        
        iTunesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        iTunesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        iTunesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        iTunesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        iTunesButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        if let url = URL(string: album?.itunesURL ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}

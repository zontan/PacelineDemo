//
//  AlbumTableViewCell.swift
//  PacelineDemo
//
//  Created by Jonathan  Fotland on 7/25/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    
    var albumImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(album: Album) {
        var content = self.defaultContentConfiguration()

        // Configure content.
        content.text = album.name
        content.secondaryText = album.artist
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        self.contentConfiguration = content
        
        UIImage.load(urlString: album.imgURL) { image in
            content.image = image
            DispatchQueue.main.async {
                self.contentConfiguration = content
            }
        }
    }

    override func prepareForReuse() {
        albumImage = nil
        contentConfiguration = nil
    }
}

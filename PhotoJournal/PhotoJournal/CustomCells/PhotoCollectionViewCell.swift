//
//  PhotoCollectionViewCell.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/23/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    public func setUp(_ entry: PhotoJournalEntry){
        optionsButton.setTitle("", for: .normal)
        optionsButton.setBackgroundImage( UIImage(systemName: "ellipsis"), for: .normal)
        titleLabel.text = entry.title
        dateLabel.text = dateLabel.text?.dateToString(Date())
        if let picture = UIImage(data: entry.imageData){
            imageView.image = picture
        } else {
            imageView.image = UIImage(systemName: "exclamationmark.triangle")
        }
    }
}

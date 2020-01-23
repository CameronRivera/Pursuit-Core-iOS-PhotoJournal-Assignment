//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/22/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class PhotoJournalEntriesController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var savedPhotos = ["Flat", "Wide", "Round", "Pizza", "Potatoes", "Piano"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension PhotoJournalEntriesController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let xCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Could not dequeue collectionViewCell as a PhotoCollectionViewCell")
        }
        xCell.imageView.image = UIImage(systemName: "film")
        xCell.backgroundColor = .darkGray
        return xCell
    }
}

extension PhotoJournalEntriesController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.width * 0.8)
    }
}



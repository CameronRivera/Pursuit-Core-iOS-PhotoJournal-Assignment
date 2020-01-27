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
    
    var savedPhotos = [PhotoJournalEntry](){
        didSet{
            collectionView.reloadData()
        }
    }
    var persistenceHandler = PersistenceHelper<PhotoJournalEntry>("JournalEntries.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUp()
    }
    
    private func setUp(){
        navigationItem.title = "Photo Journal Entries"
        collectionView.dataSource = self
        collectionView.delegate = self
        do {
            savedPhotos = try persistenceHandler.getObjects()
        } catch {
            print("Error Loading Entries: \(error)")
        }
    }
    
    private func deleteEntry(at position: Int){
        do {
            try persistenceHandler.remove(position)
        } catch {
            print("Encountered error when attempting to delete entry: \(error)")
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem){
        guard let photoJournalEntryVC = storyboard?.instantiateViewController(identifier: "PhotoJournalEntryViewController") as? PhotoJournalEntryViewController else {
            fatalError("Error encountered while attempting to create an instance of PhotoJournalEntryViewController.")
        }
        photoJournalEntryVC.currentEntry = PhotoJournalEntry(imageData: Data(), title: "", date: "")
        navigationController?.pushViewController(photoJournalEntryVC, animated: true)
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
        xCell.delegate = self
        xCell.setUp(savedPhotos[indexPath.row])
        return xCell
    }
}

extension PhotoJournalEntriesController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.width * 0.8)
    }
}

extension PhotoJournalEntriesController: PhotoCollectionViewCellDelegate {
    
    func displaySettings(_ cell: PhotoCollectionViewCell) {
        
        guard let index = collectionView.indexPath(for: cell) else {
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            self?.deleteEntry(at: index.row)
            self?.savedPhotos.remove(at: index.row)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let editAction = UIAlertAction(title: "Edit", style: .default) { [weak self] alertAction in
            guard let photoJournalEntriesVC = self?.storyboard?.instantiateViewController(identifier: "PhotoJournalEntryViewController") as? PhotoJournalEntryViewController else {
                fatalError("Could not create new instance of PhotoJournalEntryViewController")
            }
            do {
                let entries = try self!.persistenceHandler.getObjects()
                photoJournalEntriesVC.currentEntry = entries[index.row]
                photoJournalEntriesVC.state = SeguedState.fromEdit
                photoJournalEntriesVC.indexOfCurrentEntry = index.row
                self?.navigationController?.pushViewController(photoJournalEntriesVC, animated: true)
                
            } catch {
                print("Error loading entry: \(error)")
            }
            
        }
        let shareAction = UIAlertAction(title: "Share", style: .default) { [weak self] alertAction in
            let activityController = UIActivityViewController(activityItems: [UIImage(data: self!.savedPhotos[index.row].imageData)!], applicationActivities: nil)
            self?.present(activityController, animated: true)
        }
        
        alertController.addAction(editAction)
        alertController.addAction(shareAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
}



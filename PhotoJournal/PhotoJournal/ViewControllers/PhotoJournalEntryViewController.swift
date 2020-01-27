//
//  PhotoJournalEntryViewController.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/23/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import AVFoundation

enum SeguedState{
    case fromEdit
    case fromAdd
}

class PhotoJournalEntryViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var localPhotosButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var currentEntry: PhotoJournalEntry?
    var persistenceHandler = PersistenceHelper<PhotoJournalEntry>("JournalEntries.plist")
    var state = SeguedState.fromAdd
    var indexOfCurrentEntry: Int?
    
    private var imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1.0
        imageView.superview?.backgroundColor = UIColor.gray
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1.0
    }
    
    private func setUp(){
        imagePickerController.delegate = self
        navigationItem.rightBarButtonItem?.title = "Save Changes"
        navigationItem.rightBarButtonItem?.isEnabled = false
        textView.textColor = UIColor.black
        textView.delegate = self
        
        if state == SeguedState.fromEdit{
            editSetUp()
        } else {
            textView.text = "Add a title here. Use one of the buttons at the bottom to add an image."
        }
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            cameraButton.isEnabled = false
            return
        }
    }
    
    private func editSetUp(){
        guard let entry = currentEntry,
            let image = UIImage(data: entry.imageData) else {
                print("Could not load image to edit")
                return
        }
        cameraButton.isEnabled = false
        localPhotosButton.isEnabled = false
        imageView.image = image
        textView.text = entry.title
    }
    
    @IBAction func photolibraryButtonPressed(_ sender: UIBarButtonItem){
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @IBAction func takeNewPhotoButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
    }
    
    @IBAction func saveChangesButtonPressed(_ sender: UIBarButtonItem) {
        do {
            guard var entry = currentEntry else {
                print("Returned Nothing")
                return
            }
            if state == .fromAdd{
                entry.date = textView.text.dateToString(Date())
                entry.title = textView.text
                try persistenceHandler.saveObject(entry)
            } else {
                guard let index = indexOfCurrentEntry else {
                    print("Could not obtain indexOfCurrentEntry")
                    return
                }
                entry.title = textView.text
                try persistenceHandler.edit(index, entry)
            }
            
            showAlert("Success", "Entry was saved to the device") { [weak self] alertAction in
                self?.navigationController?.popViewController(animated: true)
            }
            
        } catch {
            showAlert("Error Persisting Entry", "Could not persist data to the device.")
        }
    }

}

extension PhotoJournalEntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            showAlert("Error Loading Image", "Unable to load image")
            return
        }
        
        let size = UIScreen.main.bounds.size
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        imageView.image = image.resizeImage(rect.size.height, rect.size.width)
        
        if let imageData = image.jpegData(compressionQuality: 1.0){
            currentEntry?.imageData = imageData
        }
        
        if textView.text != nil &&  textView.text != ""{
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoJournalEntryViewController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard imageView.image != nil else {
            return
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
}

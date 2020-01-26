//
//  PhotoJournalEntryViewController.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/23/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class PhotoJournalEntryViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var localPhotosButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var currentEntry: PhotoJournalEntry?
    
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
        navigationItem.rightBarButtonItem?.title = "Save Changes"
        navigationItem.rightBarButtonItem?.isEnabled = false
        textView.text = "Type Photo Journal entry title here, and add a photo using one of the options below."
        textView.textColor = UIColor.gray
    }
    
    @IBAction func photolibraryButtonPressed(_ sender: UIBarButtonItem){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @IBAction func takeNewPhotoButtonPressed(_ sender: UIBarButtonItem) {
        
    }

}

extension PhotoJournalEntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            showAlert("Error Loading Image", "Unable to load image")
            return
        }
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
}

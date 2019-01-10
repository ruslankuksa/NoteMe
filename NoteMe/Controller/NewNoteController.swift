//
//  NewNoteController.swift
//  NoteMe
//
//  Created by Руслан Кукса on 12/19/18.
//  Copyright © 2018 Ruslan Kuksa. All rights reserved.
//

import UIKit
import CoreData

protocol newNoteDelegate {
    func userSaveNewNote(title: String, note: String)
}

class NewNoteController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var noteTextView: UITextView!
    
    var delegate: newNoteDelegate?
    //var noteIsSaved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        
        titleTextView.delegate = self
        noteTextView.delegate = self
        textFieldsPreparations()
    }
    

    // MARK: - TextView before editing
    func textFieldsPreparations() {
        titleTextView.text = "Title"
        titleTextView.textColor = UIColor.lightGray
        
        noteTextView.text = "Text"
        noteTextView.textColor = UIColor.lightGray
    }
    
    // MARK: - TextView when user start editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    // MARK: - When back button pressed
    @IBAction func backButtonPressed(_ sender: Any) {
        
        if noteTextView.textColor != UIColor.lightGray && titleTextView.textColor != UIColor.lightGray {
            delegate?.userSaveNewNote(title: titleTextView.text, note: noteTextView.text)
        }
        
        navigationController?.popToRootViewController(animated: true)

    }
}

//
//  EditNoteController.swift
//  NoteMe
//
//  Created by Руслан Кукса on 12/22/18.
//  Copyright © 2018 Ruslan Kuksa. All rights reserved.
//

import UIKit

protocol editNoteDelegate {
    func editNote(title: String, note: String)
    func deleteNote(title: String, note: String)
}

class EditNoteController: UIViewController {
    
    var getTitle = String()
    var getNote = String()
    
    var delegate: editNoteDelegate?
    
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var noteText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        
        titleText.text = getTitle
        noteText.text = getNote
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        if titleText.text == "" && noteText.text == "" {
            delegate?.deleteNote(title: titleText.text, note: noteText.text)
        } else {
           delegate?.editNote(title: titleText.text, note: noteText.text)
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.deleteNote(title: titleText.text, note: noteText.text)
        navigationController?.popToRootViewController(animated: true)
    }
}

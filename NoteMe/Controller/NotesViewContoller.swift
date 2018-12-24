//
//  ViewController.swift
//  NoteMe
//
//  Created by Руслан Кукса on 12/17/18.
//  Copyright © 2018 Ruslan Kuksa. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController, newNoteDelegate, editNoteDelegate {
    
    var notesArray = [Notes]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedNoteIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadNotes()
    }
    
    
    // MARK: - TableView methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! TableViewCell
        
        let note = notesArray[indexPath.row]
        
        cell.titleLabel.text = note.title
        cell.noteLabel.text = note.note
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToEditNote", sender: self)
        selectedNoteIndex = indexPath.row
    }
    
    
    // MARK: - Delegate methods
    func userSaveNewNote(title: String, note: String) {
        let newNote = Notes(context: context)
        newNote.title = title
        newNote.note = note
        notesArray.append(newNote)
        saveNote()
    }
    
    func editNote(title: String, note: String) {
        notesArray[selectedNoteIndex].setValue(title, forKey: "title")
        notesArray[selectedNoteIndex].setValue(note, forKey: "note")
        saveNote()
    }
    
    func deleteNote(title: String, note: String) {
        context.delete(notesArray[selectedNoteIndex])
        notesArray.remove(at: selectedNoteIndex)
        saveNote()
    }
    
    // MARK: - Change view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newNote" {
            let destinationVC = segue.destination as! NewNoteController
            destinationVC.delegate = self
        }
        if segue.identifier == "goToEditNote" {
            let destinationVC = segue.destination as! EditNoteController
            destinationVC.delegate = self
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.getTitle = notesArray[indexPath.row].title!
                destinationVC.getNote = notesArray[indexPath.row].note!
            }
        }
    }
    
    
    // MARK: - Data manipulations methods
    func saveNote() {

        do {
            try context.save()
        } catch {
            print("Saving error: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadNotes(with request: NSFetchRequest<Notes> = Notes.fetchRequest()) {
        
        do {
            notesArray = try context.fetch(request)
        } catch {
            print("Fetching error: \(error)")
        }
        
        tableView.reloadData()
    }
    
}


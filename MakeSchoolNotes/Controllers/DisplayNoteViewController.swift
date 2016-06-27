//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController {
    
    
    //connection to note textview/textfields
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    //create an optional note, incase notes are null
    var note: Note?
        
    override func viewDidLoad() {
    super.viewDidLoad()
    }

    //action when segue is triggered
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController //downcasting it to a ListNotesTableViewCell
        if segue.identifier == "Save" {
            // if note exists, update title and content
            if let note = note {
                let newNote = Note()
                //if note contents is null, set value to nothing
                newNote.title = noteTitleTextField.text ?? ""
                newNote.content = noteContentTextView.text ?? ""
                
                //update note using Realm framework, (current note, updated note)
                RealmHelper.updateNote(note, newNote: newNote)
            } else {
                // if note does not exist, create new note
                let note = Note()
                //if note contents is null, set value to nothing
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                note.modificationTime = NSDate()
                // add note using Realm framework --> persistent storage
                RealmHelper.addNote(note)
            }
            //retrieve notes from Realm
            listNotesTableViewController.notes = RealmHelper.retrieveNotes()
        }
    }

    //set note instructions once navigation item is triggered
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = note {
            // set existing data to existing note
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            //new note, parameters are set to nothing
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }

}


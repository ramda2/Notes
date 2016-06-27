//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

var notes: Results<Note>!

//instructions for default note page

//inherits from UITableViewController
class ListNotesTableViewController: UITableViewController {
    
    //array the holds our notes
    var notes: Results<Note>! { didSet { tableView.reloadData() } }

    override func viewDidLoad() {
        super.viewDidLoad()
        notes = RealmHelper.retrieveNotes() //retrieving the notes from Realm whent the table viw is addded
    }
    
    // returns the number of cells/notes in the table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // tells the table view what to display on the cell for the corresponding index
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // construct the cell, allows cells to be recycled in the list
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell //downcasting it to a ListNotesTableViewCell
        
        // returns the integer of the index row
        let row = indexPath.row
        
        // fetching the note in the corresponding row
        let note = notes[row]
        

        cell.noteTitleLabel.text = note.title
        cell.notePreview.text = note.content //set preview within the title section

        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()  //timestamp
        
        
        //if rows are even, color coordinate between rows
        if row % 2 == 0 { cell.backgroundColor = UIColor.clearColor() }
        return cell
    }
    
    //activated when a segue is trigggered
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // check if not null, store the identifier's indentifer
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                print("Table view cell tapped")
                
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let note = notes[indexPath.row]
                // 3
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                // 4
                displayNoteViewController.note = note
                
            } else if identifier == "addNote" { print("+ button tapped") }
        }
    }
    
    //creating an action to the unqwind segue thats coming from the DisplayNoteView
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }

    
    //used to delete a cell in the table view
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {  // checking if the editing style is delete
            //1
            RealmHelper.deleteNote(notes[indexPath.row])
            //2
            notes = RealmHelper.retrieveNotes()  //retrieving the updated note
        }
    }
}


//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by ANGELIE RAMDIAL on 6/26/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    //static methods will go here
    static func addNote(note: Note) {
        //static method that accepts a Note object as its one parameter and then saves that note to the default Realm.
        let realm = try! Realm()
        try! realm.write() {
            realm.add(note)
        }
    }
    
    static func deleteNote(note:Note) {
        let realm = try! Realm()
        try! realm.write() {
        realm.delete(note)
        }
    }
    
    static func updateNote(noteToBeUpdated: Note, newNote: Note) {
        let realm = try! Realm()
        try! realm.write() {
            noteToBeUpdated.title = newNote.title
            noteToBeUpdated.content = newNote.content
            noteToBeUpdated.modificationTime = newNote.modificationTime
        }
    }
    
    static func retrieveNotes() -> Results<Note> {
        let realm = try! Realm()
        return realm.objects(Note).sorted("modificationTime", ascending: false)
    }
}



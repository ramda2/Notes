//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by ANGELIE RAMDIAL on 6/26/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//


import Foundation
import RealmSwift

// default note
class Note: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var modificationTime = NSDate()
}



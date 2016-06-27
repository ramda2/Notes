//
//  ListNotesTableViewCell.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 10/18/15.
//  Copyright © 2015 Make School. All rights reserved.
//

import UIKit

//custom class for notes cell
class ListNotesTableViewCell: UITableViewCell {
    
    //connection to labels
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteModificationTimeLabel: UILabel!
    @IBOutlet weak var notePreview: UITextView!

}

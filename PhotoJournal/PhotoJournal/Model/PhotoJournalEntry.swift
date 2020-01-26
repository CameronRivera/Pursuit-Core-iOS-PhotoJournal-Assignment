//
//  PhotoJournalEntry.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/23/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

// TODO: Maybe put an enum here to capture the state of the entry

struct PhotoJournalEntry: Codable, Equatable{
    var imageData: Data
    var title: String
    var date: String
}

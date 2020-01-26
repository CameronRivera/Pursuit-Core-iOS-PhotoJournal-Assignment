//
//  String+Extensions.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/23/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

extension String {
    func dateToString(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d yyyy h:mm a"
        return dateFormatter.string(from: date)
    }
}

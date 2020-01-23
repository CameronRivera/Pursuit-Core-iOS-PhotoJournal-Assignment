//
//  FIleManager+Extensions.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/23/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

extension FileManager{
    
    func pathToFile(_ fileName: String) -> URL {
        return pathToDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    func pathToDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

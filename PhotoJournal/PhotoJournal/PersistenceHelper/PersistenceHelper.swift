//
//  PersistenceHelper.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/23/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct PersistenceHelper<T: Codable & Equatable>{
    
    private var fileName: String
    
    init(_ fileName: String){
        self.fileName = fileName
    }
    
    func getObjects() throws -> [T] {
        guard FileManager.default.fileExists(atPath: fileName), let data = FileManager.default.contents(atPath: fileName) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    func saveObject(_ object: T) throws {
        var savedObjects = try getObjects()
        savedObjects.append(object)
        try serializeAndSave(savedObjects)
    }
    
    func remove(_ index: Int) throws {
        var savedObjects = try getObjects()
        savedObjects.remove(at: index)
        try serializeAndSave(savedObjects)
    }
    
    func serializeAndSave(_ savedObjects: [T]) throws {
        let dataToWrite = try PropertyListEncoder().encode(savedObjects)
        try dataToWrite.write(to: FileManager.default.pathToFile(fileName), options: Data.WritingOptions.atomic)
    }
    
}

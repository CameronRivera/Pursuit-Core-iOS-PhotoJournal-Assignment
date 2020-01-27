//
//  UserDefaults.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/26/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

struct Colour{
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
}

struct UserPreferenceKeys {
    static let blueComponent = "blue"
    static let redComponent = "red"
    static let greenComponent = "green"
    static let alphaComponent = "alpha"
    static let direction = "Scroll Direction"
}

class UserPreferences {
    static let shared = UserPreferences()
    private init() {
        
    }
    
    func saveBackgroundColour(using colour: Colour){
        UserDefaults.standard.set(Float(colour.blue), forKey: UserPreferenceKeys.blueComponent)
        UserDefaults.standard.set(Float(colour.green), forKey: UserPreferenceKeys.greenComponent)
        UserDefaults.standard.set(Float(colour.red), forKey: UserPreferenceKeys.redComponent)
        UserDefaults.standard.set(Float(colour.alpha), forKey: UserPreferenceKeys.alphaComponent)
    }
    
    func saveScrollDirection(using direction: String){
        UserDefaults.standard.set(direction, forKey: UserPreferenceKeys.direction)
    }
    
    func loadBackgroundColour() -> Colour?{
        if let blue = UserDefaults.standard.object(forKey: UserPreferenceKeys.blueComponent) as? Float,
            let red = UserDefaults.standard.object(forKey: UserPreferenceKeys.redComponent) as? Float,
            let green = UserDefaults.standard.object(forKey: UserPreferenceKeys.greenComponent) as? Float,
            let alpha = UserDefaults.standard.object(forKey: UserPreferenceKeys.alphaComponent) as? Float{
            return Colour(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        }
        return nil
    }
    
    func loadScrollDirection() -> String? {
        if let direction = UserDefaults.standard.object(forKey: UserPreferenceKeys.direction) as? String {
            return direction
        }
        return nil
    }
}

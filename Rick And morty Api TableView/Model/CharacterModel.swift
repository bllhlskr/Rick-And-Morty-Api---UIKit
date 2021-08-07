//
//  CharacterModel.swift
//  Rick And morty Api TableView
//
//  Created by Halis  Kara on 4.08.2021.
//

import Foundation

// MARK: - Character JSON MODEL
struct Response :Codable {
    
    let results : [Character]
}

struct Character : Codable {
    
    let name : String
    let status : String
    let species:String
    let image : String
    
    }

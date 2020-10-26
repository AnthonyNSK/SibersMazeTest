//
//  Chest.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import Foundation

class Chest: GameObject {
    
    var content : Grail?
    
    override init() {
        super.init()
        image = "Chest.png"
        content = Grail()
        size = 80
        objectDescription = "Ключ. Открывает сундук"
    }
    
    override func takeObject() -> Bool {
        return false
    }
    
    func getGrail() -> Bool {
    
        if content != nil {
            MazeGenerator.shared.currentPlayer.inventoryObjectsArray.append(content!)
            content = nil
            return true
        } else {return false}
    }
}

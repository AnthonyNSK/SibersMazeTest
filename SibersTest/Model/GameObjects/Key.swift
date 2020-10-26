//
//  Key.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import Foundation

class Key: GameObject {
    
    override init() {
        super.init()
        image = "Key.png"
        size = 50
        objectDescription = "Ключ. Открывает сундук"
    }
    
    override func use() -> Int {
        for obj in MazeGenerator.shared.currentRoom.gameObjects {
            if obj is Chest {
                let chest = obj as! Chest
                if chest.getGrail() == true {
                    return 1
                } else { return 3 }
            }
        }
        return 2
    }
    
    override func destroy() -> Bool {
        return false
    }
    
//    func useToTheObject(obj: GameObject) -> Bool {
//        if obj is Chest {
//            return true
//        }
//        return false
//    }
}

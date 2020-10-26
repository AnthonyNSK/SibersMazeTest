//
//  GameObject.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import Foundation

class GameObject: NSObject {
    
    var image : String!
    var x: Int?
    var y: Int?
    var size: Int!
    var objectDescription: String?
    
    override init() {
        super.init()
        
    }
    func takeObject() -> Bool {
        x = nil
        y = nil
        return true
    }
    func setCoordinates(x: Int, y: Int) {
        self.x = x + MazeGenerator.shared.gameArenaIndent
        self.y = y + MazeGenerator.shared.gameArenaIndent
    }
    
    func use() -> Int {
        print("Can't use this")
        return 0
    }
    
    func destroy() -> Bool {
        return true
    }
}

//
//  Grail.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import Foundation

class Grail: GameObject {
    
    override init() {
         super.init()
         image = "Grail.png"
         size = 50
        objectDescription = "Святой Грааль"
     }
    
    override func destroy() -> Bool {
        return false
    }
    
    override func use() -> Int {
        return 4
    }
}

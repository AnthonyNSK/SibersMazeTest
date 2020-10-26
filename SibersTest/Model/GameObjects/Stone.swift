//
//  Stone.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import Foundation

class Stone: GameObject {
    
    override init() {
         super.init()
         image = "Stone.png"
         size = 50
        objectDescription = "Камень"
     }
}

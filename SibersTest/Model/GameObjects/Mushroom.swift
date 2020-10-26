//
//  Mushroom.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import Foundation

class Mushroom: GameObject {
    
       override init() {
         super.init()
         image = "Mushroom.png"
         size = 50
        objectDescription = "Гриб"
     }
}

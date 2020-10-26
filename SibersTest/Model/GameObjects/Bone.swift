//
//  Bone.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import Foundation

class Bone: GameObject {
    
       override init() {
         super.init()
         image = "Bone.png"
         size = 50
        objectDescription = "Кость"
     }
}

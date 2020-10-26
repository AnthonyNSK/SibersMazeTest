//
//  Food.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 26.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import Foundation

class Food: GameObject {
    
       override init() {
         super.init()
         image = "Food.png"
         size = 50
        objectDescription = "Еда. Увеличение шагов"
     }
    
    override func use() -> Int {
        MazeGenerator.shared.currentPlayer.limitOfSteps += 3
        return 5
    }
}

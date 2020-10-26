//
//  Player.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import UIKit

class Player: NSObject {
    var inventoryObjectsArray : [GameObject] = []
    var limitOfSteps : Int
    
    init(steps: Int) {
        self.limitOfSteps = steps
        
        super.init()
    }
    
    func addObjectToInventary(object: GameObject) {
        inventoryObjectsArray.append(object)
    }
    
    func deleteObjectAtIndex(index: Int) {
        inventoryObjectsArray.remove(at: index)
    }
    
    func getSteps() -> Int {
        return limitOfSteps
    }
    
    func makeStep() -> Bool {
        if limitOfSteps > 0 {
            limitOfSteps -= 1
        } else {return false}
        return true
    }
    
    func takeObject (obj : GameObject) {
        inventoryObjectsArray.append(obj)
    }
    
     deinit {
        print("deinit")
    }

}

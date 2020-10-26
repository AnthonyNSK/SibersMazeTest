//
//  Room.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import Foundation
import GameplayKit

enum Door {
    case up
    case right
    case down
    case left
}

class Room: NSObject {
    
    let line : Int
    let row : Int
    
    var gameObjects : [GameObject] = []
    var doors : [Door] = []
    
    
    init(line: Int, row: Int, door: Door?) {
        self.line = line
        self.row = row
        if let newDoor = door {
            doors.append(newDoor)
        }
        super.init()
        
    }
    
    func takeObjectIfPossible(index: Int) -> Bool {
        if gameObjects[index].takeObject() == true {
            MazeGenerator.shared.currentPlayer.takeObject(obj: gameObjects[index])
            gameObjects.remove(at: index)
            return true
        }
        return false
    }
    
    func createDoor() -> Door? {
        let possibleDoors : [Door] = [Door.up, Door.down, Door.right, Door.left]
        let shuffledPossibleDoors = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleDoors) as! [Door]
        
        for newPossibleDoor in shuffledPossibleDoors {
            if doors.contains(newPossibleDoor) != true
            {
            doors.append(newPossibleDoor)
            return newPossibleDoor
            }
        }
        return nil
    }
    
    func checkingObjectsOverlays(x: Int, y: Int, size: Int) -> Bool {
        for obj in gameObjects {
            let distance = sqrt(Double((obj.x!-x)*(obj.x!-x)+(obj.y!-y)*(obj.y!-y)))
            if distance < Double(obj.size/2+size/2) {
                return false
            }
        }
        return true
    }
    
    
}

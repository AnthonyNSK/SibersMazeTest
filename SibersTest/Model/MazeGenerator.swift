//
//  MazeGenerator.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import UIKit

class MazeGenerator: NSObject {
    static let shared = MazeGenerator()
    
    let gameArenaIndent = 30
    var roomsArray : [Room] = [Room(line: 0, row: 0, door: nil)]
    var objectsArray : [GameObject] = []
    var currentRoom : Room!
    var currentPlayer : Player!
    
    private override init() {
        super.init()
        
    }
    
    func generationOfTheMaze (numberOfRooms: Int) {
        currentRoom = roomsArray[0]
        
        if numberOfRooms > 1 {
            for _ in 0...numberOfRooms-2 {
                createRoomOrAddDoorToExistingRoom()
            }
        }
        print(roomsArray.count)
        
        createPlayer(numberOfRooms: numberOfRooms)
    }
    
    func createPlayer(numberOfRooms: Int) {
        currentPlayer = Player(steps: numberOfRooms*2)
    }
    
    func createRoomOrAddDoorToExistingRoom() {
        let room = roomsArray.randomElement()!
        switch room.createDoor() {
        case .up:
            let newRoom = Room(line: room.line-1, row: room.row, door: .down)
            if roomExist(newRoom: newRoom) == false {
                roomsArray.append(newRoom)
            } else { createRoomOrAddDoorToExistingRoom() }
        case .down:
            let newRoom = Room(line: room.line+1, row: room.row, door: .up)
            if roomExist(newRoom: newRoom) == false {
                roomsArray.append(newRoom)
            } else { createRoomOrAddDoorToExistingRoom() }
        case .left:
            let newRoom = Room(line: room.line, row: room.row-1, door: .right)
            if roomExist(newRoom: newRoom) == false {
                roomsArray.append(newRoom)
            } else { createRoomOrAddDoorToExistingRoom() }
        case .right:
            let newRoom = Room(line: room.line, row: room.row+1, door: .left)
            if roomExist(newRoom: newRoom) == false {
                roomsArray.append(newRoom)
            } else { createRoomOrAddDoorToExistingRoom() }
        default:
            createRoomOrAddDoorToExistingRoom()
        }
    }
    
    func roomExist(newRoom: Room) -> Bool {
        for room in roomsArray {
            if newRoom.line == room.line && newRoom.row == room.row {
                return true
            }
        }
        return false
    }
    
    func addObjectToRandomRoom(obj: GameObject, sizeObjectsArena: Int) {
        let x = Int.random(in: 0...sizeObjectsArena)
        let y = Int.random(in: 0...sizeObjectsArena)
        let randomRoom = roomsArray.randomElement()!
        if randomRoom.checkingObjectsOverlays(x: x, y: y, size: obj.size) == true {
            obj.setCoordinates(x: x, y: y)
            randomRoom.gameObjects.append(obj)
            return
        }
        addObjectToRandomRoom(obj: obj, sizeObjectsArena: sizeObjectsArena)
    }
    
    func generationOfGameObjects (sizeObjectsArena: Int) {
        let chest = Chest()
        addObjectToRandomRoom(obj: chest, sizeObjectsArena: sizeObjectsArena)
        let key = Key()
        addObjectToRandomRoom(obj: key, sizeObjectsArena: sizeObjectsArena)
        let food = Food()
        addObjectToRandomRoom(obj: food, sizeObjectsArena: sizeObjectsArena)
        
    
        for _ in 0...roomsArray.count-1 {
            let randomInt = Int.random(in: 0...2)
            switch randomInt {
            case 0:
                let bone = Bone()
                addObjectToRandomRoom(obj: bone, sizeObjectsArena: sizeObjectsArena)
            case 1:
                let stone = Stone()
                addObjectToRandomRoom(obj: stone, sizeObjectsArena: sizeObjectsArena)
            case 2:
                let mushroom  = Mushroom()
                addObjectToRandomRoom(obj: mushroom, sizeObjectsArena: sizeObjectsArena)
            default:
                print("???")
            }
        }
    }
    
    func addObjectToCurrentRoom(obj: GameObject) {
        currentRoom.gameObjects.append(obj)
    }
    
    func newGame() {
        roomsArray = [Room(line: 0, row: 0, door: nil)]
        currentRoom = roomsArray[0]
    }
    
    func goToDoor(door: Door) {
        switch door {
        case .up:
            if MazeGenerator.shared.currentRoom.doors.contains(.up) {
                for room in roomsArray {
                    if room.line == currentRoom.line-1 && room.row == currentRoom.row {
                        currentRoom = room
                        break
                    }
                }
            }
        case .down:
            if MazeGenerator.shared.currentRoom.doors.contains(.down) {
                for room in roomsArray {
                    if room.line == currentRoom.line+1 && room.row == currentRoom.row {
                        currentRoom = room
                        break
                    }
                }
            }
        case .left:
            if MazeGenerator.shared.currentRoom.doors.contains(.left) {
                for room in roomsArray {
                    if room.line == currentRoom.line && room.row == currentRoom.row-1 {
                        currentRoom = room
                        break
                    }
                }
            }
        case .right:
            if MazeGenerator.shared.currentRoom.doors.contains(.right) {
                for room in roomsArray {
                    if room.line == currentRoom.line && room.row == currentRoom.row+1 {
                        currentRoom = room
                        break
                    }
                }
            }
        }
    }
    
}


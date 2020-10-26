//
//  PlayViewController.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 11.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    @IBOutlet weak var upDoorView: UIImageView!
    @IBOutlet weak var leftDoorView: UIImageView!
    @IBOutlet weak var downDoorView: UIImageView!
    @IBOutlet weak var rightDoorView: UIImageView!

    @IBOutlet weak var gameObjectsArenaView: UIView!
    @IBOutlet weak var limitOfStepsLabel: UILabel! {didSet {
        limitOfStepsLabel.text = "Лимит шагов: " + "\(MazeGenerator.shared.currentPlayer.getSteps())"
    }}
    @IBOutlet weak var inventoryCollectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var useButton: UIButton!
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var destroyButton: UIButton!
    
    var objectViewsArray : [UIImageView] = []
    var selectedIndex : Int? = nil { didSet {
        if selectedIndex == nil {
            useButton.isHidden = true
            dropButton.isHidden = true
            destroyButton.isHidden = true
            
            descriptionLabel.text = ""
        } else {
            useButton.isHidden = false
            dropButton.isHidden = false
            destroyButton.isHidden = false
            
            descriptionLabel.text = MazeGenerator.shared.currentPlayer.inventoryObjectsArray[selectedIndex!].objectDescription
        }
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sizeArena = gameObjectsArenaView.bounds.size.height
        MazeGenerator.shared.generationOfGameObjects(sizeObjectsArena: Int(sizeArena) - MazeGenerator.shared.gameArenaIndent*2)
        showRoom(room: MazeGenerator.shared.currentRoom)
        

   
    }
    
    @objc func touchAGameObject(_ sender: UITapGestureRecognizer) {
        var i = 0
        for obj in objectViewsArray {
            if sender.view == obj {
                if MazeGenerator.shared.currentRoom.takeObjectIfPossible(index: i) == true {
                    objectViewsArray.remove(at: i)
                    sender.view?.removeFromSuperview()
                    inventoryCollectionView.reloadData()
                }
            }
            i += 1
        }
    }
    
    func showRoom(room: Room) {
        showDoors(room: room)
        showGameObjects(room: room)
    }
    
    func showDoors(room: Room) {
        leftDoorView.isHidden = true
        upDoorView.isHidden = true
        rightDoorView.isHidden = true
        downDoorView.isHidden = true
        
        for door in room.doors {
            switch door {
            case .up:
                upDoorView.isHidden = false
            case .left:
                leftDoorView.isHidden = false
            case .down:
                downDoorView.isHidden = false
            case .right:
                rightDoorView.isHidden = false
            }
        }
    }
    
    @IBAction func destroyAction(_ sender: UIButton) {
        if selectedIndex != nil {
            let selectedObject = MazeGenerator.shared.currentPlayer.inventoryObjectsArray[selectedIndex!]
            if selectedObject.destroy() == true {
                MazeGenerator.shared.currentPlayer.deleteObjectAtIndex(index: self.selectedIndex!)
                self.selectedIndex = nil
                inventoryCollectionView.reloadData()
            } else {
                showMessage(str: "Этот объект нельзя уничтожить")
            }
        }
    }
    
    @IBAction func dropAction(_ sender: UIButton) {
        showAlertForSelectingCoordinates()
    }
    
    @IBAction func useAction(_ sender: UIButton) {
        if selectedIndex != nil {
            let selectedObject = MazeGenerator.shared.currentPlayer.inventoryObjectsArray[selectedIndex!]
            var str = String()
            switch selectedObject.use() {
            case 0:
                str = "Не могу использовать предмет"
            case 1:
                str = "Сундук успешно открыт!"
                inventoryCollectionView.reloadData()
            case 2:
                str = "Нет сундука в комнате"
            case 3:
                str = "Вы уже достали грааль"
            case 4:
                victory()
                return
            case 5:
                str = "Вы получили дополнительные шаги"
                limitOfStepsLabel.text = "Лимит шагов: " + "\(MazeGenerator.shared.currentPlayer.getSteps())"
                MazeGenerator.shared.currentPlayer.deleteObjectAtIndex(index: selectedIndex!)
                inventoryCollectionView.reloadData()
            default:
                print("???")
            }
            
            showMessage(str: str)
        }
        
    }
    
    @IBAction func tapTheDoor(_ sender: UITapGestureRecognizer) {
        if MazeGenerator.shared.currentPlayer.makeStep() == false {
            gameOver()
            return
        }
        
        
        
        switch sender.view {
        case leftDoorView:
            MazeGenerator.shared.goToDoor(door: .left)
            
        case rightDoorView:
            MazeGenerator.shared.goToDoor(door: .right)
            
        case upDoorView:
            MazeGenerator.shared.goToDoor(door: .up)
            
        case downDoorView:
            MazeGenerator.shared.goToDoor(door: .down)
            
        default:
            print("Can't get out")
        }
        
        showRoom(room: MazeGenerator.shared.currentRoom)
        limitOfStepsLabel.text = "Лимит шагов: " + "\(MazeGenerator.shared.currentPlayer.getSteps())"
        
    }
    
    func showAlertForSelectingCoordinates() {
        let sizeArena = gameObjectsArenaView.bounds.size.height
        let alert = UIAlertController(title: "Задайте координаты", message: "В диапазоне от 0 до \(Int(sizeArena) - MazeGenerator.shared.gameArenaIndent*2)", preferredStyle: .alert)
        alert.addTextField { (textFieldX) in
            textFieldX.placeholder = "Координата X"
            textFieldX.keyboardType = .numberPad
        }
        alert.addTextField { (textFieldY) in
            textFieldY.placeholder = "Координата Y"
            textFieldY.keyboardType = .numberPad
        }

        let action = UIAlertAction(title: "OK", style: .default) { [weak alert] _ in
            guard let alertController = alert, let textFieldX = alertController.textFields?[0], let textFieldY = alertController.textFields?[1] else { return }

            let x = Int(textFieldX.text!) ?? -1
            let y = Int(textFieldY.text!) ?? -1
            
            guard x >= 0, x <= Int(sizeArena) - MazeGenerator.shared.gameArenaIndent*2, y >= 0, y <= Int(sizeArena) - MazeGenerator.shared.gameArenaIndent*2  else {return}
            print("Условия выполнены")
            
            if self.selectedIndex != nil {
                let selectedObj = MazeGenerator.shared.currentPlayer.inventoryObjectsArray[self.selectedIndex!]

                if MazeGenerator.shared.currentRoom.checkingObjectsOverlays(x: x, y: y, size: selectedObj.size) == true {
                    selectedObj.setCoordinates(x: x, y: y)
                    MazeGenerator.shared.currentPlayer.deleteObjectAtIndex(index: self.selectedIndex!)
                    
                    MazeGenerator.shared.addObjectToCurrentRoom(obj: selectedObj)
                    self.showGameObjects(room: MazeGenerator.shared.currentRoom)
                    self.inventoryCollectionView.reloadData()
                    
                    self.selectedIndex = nil
                } else {
                    self.showMessage(str: "В этом месте другой предмет")
                }
            
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func showMessage(str: String) {
        let alert = UIAlertController(title: str, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func gameOver() {
        let alert = UIAlertController(title: "Game Over", message: "Вы потратили все шаги", preferredStyle: .alert)
        let action = UIAlertAction(title: "New Game", style: .default) { (alert) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func victory() {
        let alert = UIAlertController(title: "Victory", message: "Поздравляем, вы победили!", preferredStyle: .alert)
        let action = UIAlertAction(title: "New Game", style: .default) { (alert) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
         MazeGenerator.shared.newGame()
     }
    
    func showGameObjects(room: Room) {
        
        for imageView in objectViewsArray {
            imageView.removeFromSuperview()
        }
        objectViewsArray.removeAll()
        
        let objectsArray = room.gameObjects
        for obj in objectsArray {
            let objectImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: obj.size, height: obj.size))
            objectImageView.image = UIImage(named: obj.image)
            objectImageView.center = CGPoint(x: obj.x!, y: obj.y!)
            gameObjectsArenaView.addSubview(objectImageView)
            objectViewsArray.append(objectImageView)
            print("The object view is added")
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchAGameObject(_ :)))
            objectImageView.addGestureRecognizer(tapGesture)
            objectImageView.isUserInteractionEnabled = true
        }
    }
    
}

// MARK: - CollectionViewDelegate and DataSource

extension PlayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MazeGenerator.shared.currentPlayer.inventoryObjectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! InventoryCollectionViewCell
        
        let inventoryImage = UIImage(named: MazeGenerator.shared.currentPlayer.inventoryObjectsArray[indexPath.row].image)
        cell.objectIamge = inventoryImage
        
        if selectedIndex == indexPath.row
        {
            cell.backgroundColor = .blue
        }
        else
        {
            cell.backgroundColor = .none
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition:.centeredHorizontally)
        // Почему-то корректно работает только на устройстве
        selectedIndex = indexPath.row
        
        collectionView.reloadData()
    }
    
    
}

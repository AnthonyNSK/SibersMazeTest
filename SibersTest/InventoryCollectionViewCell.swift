//
//  InventoryCollectionViewCell.swift
//  SibersTest
//
//  Created by Kuzhelev Anton on 22.10.2020.
//  Copyright © 2020 Kuzhelev Anton. All rights reserved.
//

import UIKit

class InventoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var inventaryImageView: UIImageView!
    
    var objectIamge : UIImage! { didSet {
        inventaryImageView.image = objectIamge
    }}
}

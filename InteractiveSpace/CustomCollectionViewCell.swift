//
//  CustomCollectionViewCell.swift
//  InteractiveSpace
//
//  Created by Evan Bacon on 9/24/16.
//  Copyright © 2016 brix. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            self.imageView.image = self.image
        }
    }
}

//
//  FlexibleFlowLayout.swift
//  InteractiveSpace
//
//  Created by Evan Bacon on 9/24/16.
//  Copyright © 2016 brix. All rights reserved.
//

import UIKit

class FlexibleFlowLayout: UICollectionViewFlowLayout
{
    init(frame: CGRect = UIScreen.main.bounds, columns: Int = 3, interitemSpacing: CGFloat = 2.0, lineSpacing: CGFloat = 2.0) {
        super.init()
        
        let interitemSpacingOffset = (interitemSpacing * CGFloat(columns - 1))
        let availableWidth = frame.width - interitemSpacingOffset
        let itemWidth = availableWidth / CGFloat(columns)
        self.minimumInteritemSpacing = interitemSpacing
        self.minimumLineSpacing = lineSpacing
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

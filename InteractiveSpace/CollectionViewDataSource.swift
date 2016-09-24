//
//  CollectionViewDataSource.swift
//  CollectionViewTransition
//
//  Created by Evan Bacon on 9/24/16.
//  Copyright © 2016 Michael Babiy. All rights reserved.
//

import Foundation
import  UIKit

class CollectionViewDataSource:NSObject {
    fileprivate var data = [UIImage]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var collectionView:UICollectionView!
    init(collectionView:UICollectionView) {
        super.init()
        self.collectionView = collectionView
        self.setupSource()
        
    }
    private func setupSource() {
        for i in 0...10 {
            guard let image = UIImage(named: "jelly_\(i)") else {return}
            self.data.append(image)
        }
    }
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count * 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        customCell.image = self.data[(indexPath as NSIndexPath).row % self.data.count]
        return customCell
    }
}

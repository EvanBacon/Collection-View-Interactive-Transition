//
//  ViewController.swift
//  InteractiveSpace
//
//  Created by Evan Bacon on 9/24/16.
//  Copyright © 2016 brix. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var layouts = [UICollectionViewLayout]()
    fileprivate var transitionLayout: UICollectionViewTransitionLayout?
    
    fileprivate var postPinchTransitionCompleted = true
    fileprivate var pinchDirectionDetermined = false
    fileprivate var initialPinchScale: CGFloat = 0.0
    fileprivate var dataSource:CollectionViewDataSource!
 
    fileprivate let levels = 6
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupDataSource()
        self.setupLayouts()
        self.setupAppearance()
        self.setupPinchGestureRecognizer()
    }
}

extension ViewController {
    fileprivate func setupDataSource() {
        dataSource = CollectionViewDataSource(collectionView: self.collectionView)
        self.collectionView.dataSource = dataSource
    }
    
    fileprivate func setupLayouts() {
        for i in 1...levels {
            layouts.append(FlexibleFlowLayout(columns: i))
        }
    }
    
    fileprivate func setupAppearance() {
        self.collectionView.collectionViewLayout = layouts.last!
    }
    
    fileprivate func setupPinchGestureRecognizer() {
        self.collectionView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(ViewController.handlePinchGestureRecognizer(_:))))
    }
}

extension ViewController {
    func handlePinchGestureRecognizer(_ gesture: UIPinchGestureRecognizer) {
        guard !(gesture.velocity < 0 && self.collectionView.collectionViewLayout == layouts.last!), self.postPinchTransitionCompleted  else { return }
        
        if (gesture.state == .began) {
            self.initialPinchScale = gesture.scale
            self.pinchDirectionDetermined = false
        } else if (gesture.state == .changed) && self.pinchDirectionDetermined == false {
            self.determineNextLayout(velocity: gesture.velocity)
        }
            
        guard let transitionLayout = self.transitionLayout else {return}
        transitionLayout.transitionProgress = fabs(self.initialPinchScale - gesture.scale) / self.initialPinchScale
            
        if (gesture.state == .ended) {
            transitionLayout.transitionProgress > 0.25 ? self.collectionView.finishInteractiveTransition() : self.collectionView.cancelInteractiveTransition()
            self.postPinchTransitionCompleted = false
        }
    }
    
    private func determineNextLayout(velocity:CGFloat) {
        self.pinchDirectionDetermined = true
        let endLayout = self.nextLayoutForVelocity(velocity)
        
        guard endLayout != self.collectionView.collectionViewLayout else { return }
        
        self.transitionLayout = self.collectionView.startInteractiveTransition(to: endLayout, completion:{ (completed, finished) -> Void in
            if completed {
                self.transitionLayout = nil
                self.postPinchTransitionCompleted = true
            }
        })
        
    }
    
    private func nextLayoutForVelocity(_ velocity: CGFloat) -> UICollectionViewLayout {
        let index = Int(layouts.index(of: self.collectionView.collectionViewLayout)!)
        let next = (velocity > 0 ? -1 : 1)
        
        return layouts[min(layouts.count - 1 , max( 0, index + next))]
    }
}

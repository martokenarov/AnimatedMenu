//
//  CustomFlowLayout.swift
//  PopUpMenu
//
//  Created by Marto Kenarov on 17.04.18.
//  Copyright © 2018 Marto Kenarov. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    var insertingIndexPaths = [IndexPath]()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        insertingIndexPaths.removeAll()
        
        for update in updateItems {
            if let indexPath = update.indexPathAfterUpdate,
                update.updateAction == .insert {
                insertingIndexPaths.append(indexPath)
            }
            
            if let indexPath = update.indexPathAfterUpdate, update.updateAction == .delete {
                insertingIndexPaths.remove(at: indexPath.row)
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        insertingIndexPaths.removeAll()
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr: UICollectionViewLayoutAttributes? = layoutAttributesForItem(at: itemIndexPath)
        attr?.transform = CGAffineTransform(scaleX: 0.3, y: 0.5)
        attr?.center = CGPoint(x: (self.collectionView?.bounds.midX)!, y: (self.collectionView?.bounds.maxY)!)
        
        return attr
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attr = layoutAttributesForItem(at: itemIndexPath)?.copy() as? UICollectionViewLayoutAttributes {
            attr.transform = CGAffineTransform(scaleX: 0.3, y: 0.5)
            attr.center = CGPoint(x: (collectionView?.bounds.midX)!, y: (collectionView?.bounds.maxY)!)
            
            return attr
        } else {
            return nil
        }
    }
}

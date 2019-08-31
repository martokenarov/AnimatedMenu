//
//  Animator.swift
//  PopUpMenu
//
//  Created by Marto Kenarov on 22.04.18.
//  Copyright © 2018 Marto Kenarov. All rights reserved.
//

import Foundation
import UIKit

enum MenuCellState {
    case appear
    case disappear
}

class Animator {
    static func animateCells(for collectionView: UICollectionView, selectedIndexPath: IndexPath, forMenuCellState state: MenuCellState, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        
        if  let selectedCell = collectionView.cellForItem(at: selectedIndexPath) {
            
            let selectedCellPosition = self.getCellPosition(collectionView: collectionView, at: selectedIndexPath)
            
            let visibleCells = collectionView.visibleCells
            
            visibleCells.forEach({ (cell) in
                var positionX: CGFloat? = nil
                var positionY: CGFloat? = nil
                var alpha: CGFloat = 0
                var duration = 0.5
                
                if let indexPath = collectionView.indexPath(for: cell) {
                    
                    let cellPosition = self.getCellPosition(collectionView: collectionView, at: indexPath)
                    
                    if selectedCell != cell {
                        
                        if selectedCellPosition.x == cellPosition.x && selectedCellPosition.y < cellPosition.y {
                            // move this cell to right and then return it
                            duration = 0.3
                            if state == .disappear {
                                alpha = 0.0
                                positionY = cell.frame.origin.y + collectionView.frame.size.height
                            } else if state == .appear {
                                alpha = 1.0
                                positionY = cell.frame.origin.y - collectionView.frame.size.height
                            }
                            
                        } else if selectedCellPosition.x > cellPosition.x && selectedCellPosition.y == cellPosition.y {
                            if state == .disappear {
                                alpha = 0.0
                                positionX = cell.frame.origin.x - collectionView.frame.size.height
                            } else if state == .appear {
                                alpha = 1.0
                                positionX = cell.frame.origin.x + collectionView.frame.size.height
                            }
                            
                        } else if selectedCellPosition.x < cellPosition.x && selectedCellPosition.y == cellPosition.y {
                            
                            if state == .disappear {
                                alpha = 0.0
                                positionX = cell.frame.origin.x + collectionView.frame.size.height
                            } else if state == .appear {
                                alpha = 1.0
                                positionX = cell.frame.origin.x - collectionView.frame.size.height
                            }
                            
                        } else if selectedCellPosition.x == cellPosition.x && selectedCellPosition.y > cellPosition.y {
                            duration = 0.3
                            if state == .disappear {
                                alpha = 0.0
                                positionY = cell.frame.origin.y - collectionView.frame.size.height
                            } else if state == .appear {
                                alpha = 1.0
                                positionY = cell.frame.origin.y + collectionView.frame.size.height
                            }
                            
                        } else if selectedCellPosition.x == cellPosition.x && selectedCellPosition.y < cellPosition.y {
                            // move this cell to right and then return it
                            duration = 0.3
                            if state == .disappear {
                                alpha = 0.0
                                positionY = cell.frame.origin.y + collectionView.frame.size.height
                            } else if state == .appear {
                                alpha = 1.0
                                positionY = cell.frame.origin.y - collectionView.frame.size.height
                            }
                            
                        } else if selectedCellPosition.x > cellPosition.x && selectedCellPosition.y < cellPosition.y {
                            
                            if state == .disappear {
                                alpha = 0.0
                                positionX = cell.frame.origin.x - collectionView.frame.size.height
                                positionY = cell.frame.origin.y + collectionView.frame.size.height
                                
                            } else if state == .appear {
                                alpha = 1.0
                                positionX = cell.frame.origin.x + collectionView.frame.size.height
                                positionY = cell.frame.origin.y - collectionView.frame.size.height
                            }
                            
                        } else if selectedCellPosition.x > cellPosition.x && selectedCellPosition.y > cellPosition.y {
                            
                            if state == .disappear {
                                alpha = 0.0
                                positionX = cell.frame.origin.x - collectionView.frame.size.height
                                positionY = cell.frame.origin.y - collectionView.frame.size.height
                                
                            } else if state == .appear {
                                alpha = 1.0
                                positionX = cell.frame.origin.x + collectionView.frame.size.height
                                positionY = cell.frame.origin.y + collectionView.frame.size.height
                            }
                            
                        } else if selectedCellPosition.x < cellPosition.x && selectedCellPosition.y > cellPosition.y {
                            
                            if state == .disappear {
                                alpha = 0.0
                                positionX = cell.frame.origin.x + collectionView.frame.size.height
                                positionY = cell.frame.origin.y - collectionView.frame.size.height
                                
                            } else if state == .appear {
                                alpha = 1.0
                                positionX = cell.frame.origin.x - collectionView.frame.size.height
                                positionY = cell.frame.origin.y + collectionView.frame.size.height
                            }
                            
                        } else if selectedCellPosition.x < cellPosition.x && selectedCellPosition.y < cellPosition.y {
                            if state == .disappear {
                                alpha = 0.0
                                positionX = cell.frame.origin.x + collectionView.frame.size.height
                                positionY = cell.frame.origin.y + collectionView.frame.size.height
                                
                            } else if state == .appear {
                                alpha = 1.0
                                positionX = cell.frame.origin.x - collectionView.frame.size.height
                                positionY = cell.frame.origin.y - collectionView.frame.size.height
                            }
                        }
                        
                        cell.move(with: positionX, positionY: positionY, alpha: alpha, duration: duration)
                        
                    } else {
                        
                        if state == MenuCellState.disappear {
                            
                            selectedCell.move(with: positionX, positionY: positionY, alpha: 0.0, duration: 0.4)
                        } else {
                            
                            selectedCell.move(with: positionX, positionY: positionY, alpha: 1.0, duration: 0.4)
                        }
                    }
                }
            })
            
            completion(true)
        }
    }
    
    private static func getCellPosition(collectionView: UICollectionView, at indexPath: IndexPath) -> CGPoint {
        let attributes: UICollectionViewLayoutAttributes? = collectionView.layoutAttributesForItem(at: indexPath)
        let cellRect: CGRect? = attributes?.frame
        let cellFrameInSuperview: CGRect = collectionView.convert(cellRect ?? CGRect.zero, to: collectionView.superview)
        
        return cellFrameInSuperview.origin
    }
}

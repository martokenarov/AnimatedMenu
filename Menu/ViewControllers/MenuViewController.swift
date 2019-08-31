//
//  MenuViewController.swift
//  Menu
//
//  Created by Marto Kenarov on 22.04.18.
//  Copyright © 2018 Marto Kenarov. All rights reserved.
//

import UIKit
import Foundation

class MenuViewController: UIViewController {
    var itemCount = 0
    
    var tableTimer: Timer?
    var sourceCell: UICollectionViewCell?
    var indexPath: IndexPath?
    var animator: UIDynamicAnimator?
    
    let transition = BubbleTransition()
    
    private var dataSource = [
        Item(name: "Улици", image: UIImage(named: "avatar"), subItems: [
            Item(name: "Шахта", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Дупки", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Тротоари", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Организация на движението", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Сняг", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Други", image: UIImage(named: "avatar"), subItems: [])
            ]),
        Item(name: "Транспорт и паркиране", image: UIImage(named: "avatar"), subItems: [
            Item(name: "Изоставени автомобили", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Паркиране", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Градски транспорт", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Други", image: UIImage(named: "avatar"), subItems: [])
            ]),
        Item(name: "Замърсяване", image: UIImage(named: "avatar"), subItems: [
            Item(name: "Кофи", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Замърсени площи", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Вредители", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Замърсен въздух", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Други", image: UIImage(named: "avatar"), subItems: [])
            ]),
        Item(name: "Съоръжения", image: UIImage(named: "avatar"), subItems: [
            Item(name: "Осветление", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Електрически", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "ВиК", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Паркови", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Други", image: UIImage(named: "avatar"), subItems: [])
            ]),
        Item(name: "Зеленина и природа", image: UIImage(named: "avatar"), subItems: [
            Item(name: "Опасни дървета", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Неокосени площи", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Други", image: UIImage(named: "avatar"), subItems: [])
            ]),
        Item(name: "Детски площадки", image: UIImage(named: "avatar"), subItems: [
            Item(name: "Опасни площадки", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Замърсени площадки", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Други", image: UIImage(named: "avatar"), subItems: [])
            ]),
        Item(name: "Сгради и съоръжения", image: UIImage(named: "avatar"), subItems: [
            Item(name: "Опасна сграда", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Незаконен строеж", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Други", image: UIImage(named: "avatar"), subItems: [])
            ]),
        Item(name: "Обществен ред", image: UIImage(named: "avatar"), subItems: [
            Item(name: "Шум", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Незаконна дейност", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Опасни животни", image: UIImage(named: "avatar"), subItems: []),
            Item(name: "Други", image: UIImage(named: "avatar"), subItems: [])
            ]),
        Item(name: "Други", image: UIImage(named: "avatar"), subItems: [])]
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        
        self.collectionView?.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        
        customizeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.closeBtn.alpha = 1.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableTimer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(self.insertCells), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.closeBtn.alpha = 0.0
    }
    
    @objc func insertCells() {
        if self.itemCount < self.dataSource.count {
            
            self.collectionView?.performBatchUpdates({
                self.itemCount = self.itemCount + 1
                self.collectionView?
                    .insertItems(at: [IndexPath(item: self.itemCount - 1, section: 0)])
            }, completion: nil)
        } else {
            self.tableTimer!.invalidate()
            self.tableTimer = nil
        }
    }
    
    @objc func deletedCells() {
        self.itemCount = self.itemCount - 1
        
        if self.itemCount == 0 {
            self.tableTimer!.invalidate()
            self.tableTimer = nil
            self.dismiss(animated: false, completion: nil)
        } else if self.itemCount > 0 {
            self.collectionView?.performBatchUpdates({
                self.collectionView?.deleteItems(at: [IndexPath(item: self.itemCount, section: 0)])
            }, completion: { (finished) in
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeAction(sender: UIButton) {
        
        self.tableTimer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(self.deletedCells), userInfo: nil, repeats: true)
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell
        
        if cell == nil {
            cell = MenuCell()
        }
        
        let item = self.dataSource[indexPath.row]
        cell?.backgroundColor = UIColor.clear
        cell?.lblText.text = item.name
        cell?.imgView.image = item.image
        
        return cell!
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//                let screenRect = UIScreen.main.bounds
//                let screenWidth = screenRect.size.width
//                let cellW = (screenWidth - 2)/3
//                let cellH = cellW
        
        return CGSize(width: 100, height: 120)
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView.cellForItem(at: indexPath) != nil else {
            fatalError("no cell at \(indexPath)")
        }
        
        let item = self.dataSource[indexPath.row]
        
        if item.subItems.count > 0 {
            self.indexPath = indexPath
            
            Animator.animateCells(for: collectionView, selectedIndexPath: indexPath, forMenuCellState: .disappear, completion: {_ in
                self.performSegue(withIdentifier: "SubMenuIdentifier", sender: collectionView.cellForItem(at: indexPath))
            })
        } else {
            print("hasn't sub items")
        }
    }
}

extension MenuViewController: UIViewControllerTransitioningDelegate {
    // MARK: UIViewControllerTransitioningDelegate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SubMenuViewController {
            
            controller.delegate = self
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
            
            if let indexPath = self.indexPath {
                controller.item = self.dataSource[indexPath.row]
            }
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        
        if let indexPath = self.indexPath, let selectedCell = collectionView?.cellForItem(at: indexPath) {
            
            transition.startingPoint = selectedCell.center
            transition.bubbleColor = UIColor.clear//selectedCell.backgroundColor!
        }

        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        
        if let indexPath = self.indexPath, let selectedCell = collectionView?.cellForItem(at: indexPath) {
            
            transition.startingPoint = selectedCell.center
            transition.bubbleColor = selectedCell.backgroundColor!
            
        }

        return transition
    }
}

//MARK: SubMenuViewControllerDelegate
extension MenuViewController: SubMenuViewControllerDelegate {
    func backPressed() {
        Animator.animateCells(for: self.collectionView!, selectedIndexPath: self.indexPath!, forMenuCellState: .appear)
    }
}

extension MenuViewController {
    private func customizeUI() {
        
        self.backgroundView.layer.backgroundColor = UIColor.black.cgColor
        self.backgroundView.alpha = 0.05
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = self.backgroundView.bounds
        self.backgroundView.addSubview(visualEffectView)

        self.view.isOpaque = false
        self.view.backgroundColor = UIColor.white
        
        self.closeBtn.setImage(UIImage(named:"close"), for: .normal)
        collectionView?.setCollectionViewLayout(CustomFlowLayout(), animated: false)
        collectionView?.backgroundColor = UIColor.clear
    }
}


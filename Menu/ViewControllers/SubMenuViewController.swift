//
//  SubMenuViewController.swift
//  Menu
//
//  Created by Marto Kenarov on 22.04.18.
//  Copyright © 2018 Marto Kenarov. All rights reserved.
//

import UIKit
import QuartzCore

protocol SubMenuViewControllerDelegate: class {
    func backPressed()
}

class SubMenuViewController: UIViewController {
    var item: Item?
    weak var delegate:SubMenuViewControllerDelegate?
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        self.lblTitle.text = item?.name
//        btnBack.action = #selector(backAction(sender:))
//        btnClose.action = #selector(closeAction(sender:))
        
//        self.navigationBar.topItem?.title = item?.name
        
        customizeUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backAction(sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: {
            self.delegate?.backPressed()
        })
    }
    
    @IBAction func closeAction(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension SubMenuViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let item = self.item {
            return item.subItems.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell
        
        if cell == nil {
            cell = MenuCell()
        }
        
        if let item = self.item {
            let subItem = item.subItems[indexPath.row]
            
            cell?.lblText.text = subItem.name
            cell?.imgView.image = subItem.image
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension SubMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let screenRect = UIScreen.main.bounds
        //        let screenWidth = screenRect.size.width
        //        let cellW = (screenWidth - 2)/3
        //        let cellH = cellW
        
        return CGSize(width: 100, height: 120)
    }
}

extension SubMenuViewController {
    private func customizeUI() {
//        self.view.isOpaque = false
//        self.view.backgroundColor = UIColor.white
        self.view.alpha = 1.0
        
        self.backgroundView.layer.backgroundColor = UIColor.black.cgColor
        self.backgroundView.alpha = 0.05
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = self.backgroundView.bounds
        self.backgroundView.addSubview(visualEffectView)
        
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.alpha = 1.0
        self.collectionView.layer.cornerRadius = 3.0
        self.collectionView.setCollectionViewLayout(CustomFlowLayout(), animated: false)
    }
}

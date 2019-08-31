//
//  ViewController.swift
//  Menu
//
//  Created by Marto Kenarov on 22.04.18.
//  Copyright © 2018 Marto Kenarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var showMenuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customizeUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenuAction(sender: UIButton) {
        self.performSegue(withIdentifier: "MenuIdentifier", sender: self)
    }
}

extension ViewController {
    private func customizeUI() {
        self.showMenuBtn.layer.cornerRadius = self.showMenuBtn.frame.size.width / 2
        self.showMenuBtn.clipsToBounds = true
        self.showMenuBtn.layer.backgroundColor = UIColor.red.cgColor
        self.showMenuBtn.setImage(UIImage(named:"menu"), for: .normal)
        
        let pulseEffect = LFTPulseAnimation(repeatCount: Float.infinity, radius:40, position:self.showMenuBtn.center)
        view.layer.insertSublayer(pulseEffect, below: self.showMenuBtn.layer)
    }
}


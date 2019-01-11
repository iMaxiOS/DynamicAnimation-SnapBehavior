//
//  ViewController.swift
//  Project Dynamics
//
//  Created by Гранченко Максим on 1/11/19.
//  Copyright © 2019 Гранченко Максим. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var animation = UIDynamicAnimator()
    private let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView(box: myView)
        
    }

    private func createView(box: UIView) {
    
        box.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        box.backgroundColor = .green
        view.addSubview(box)
        
        //initialize gravity
        let gravity = UIGravityBehavior(items: [box])
        
        //initialize collizion
        let collision = UICollisionBehavior(items: [box])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        animation.addBehavior(collision)
        animation.addBehavior(gravity)       
    
    }

}


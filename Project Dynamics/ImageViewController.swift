//
//  ImageViewController.swift
//  Project Dynamics
//
//  Created by Гранченко Максим on 1/11/19.
//  Copyright © 2019 Гранченко Максим. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var myView = UIView()
    var nameLabel = UILabel()
    
    var animation: UIDynamicAnimator!
    var snapBehavior: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.frame = CGRect(x: 0, y: 0, width: 350, height: 600)
        myView.clipsToBounds = false
        myView.layer.shadowColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = CGSize.zero
        myView.layer.shadowRadius = 40
        myView.layer.shadowPath = UIBezierPath(rect: myView.bounds).cgPath
        myView.layer.shouldRasterize = false
        
        view.addSubview(myView)
        
        let imageView = UIImageView(frame: myView.bounds)
        imageView.image = UIImage(named: "Town")
        imageView.layer.cornerRadius = 40
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = true
        
        myView.addSubview(imageView)
        
        animation = UIDynamicAnimator(referenceView: view)
        snapBehavior = UISnapBehavior(item: myView, snapTo: view.center)
        animation.addBehavior(snapBehavior)
        
        createPanGesture()
        createLabel()
        
    }
    
    private func createLabel() {
        nameLabel.text = "SnapBehavior - Animation\n I like this Town"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.layer.shadowColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
        nameLabel.layer.shadowRadius = 8
        nameLabel.layer.shadowOpacity = 2
        nameLabel.layer.shadowOffset = CGSize(width: 2, height: 4)
        
        view.addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
    }
    
    private func createPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        myView.isUserInteractionEnabled = true
        myView.addGestureRecognizer(pan)
    }
    
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            animation.removeBehavior(snapBehavior)
        case .changed:
            let translation = gesture.translation(in: view)
            myView.center = CGPoint(x: myView.center.x + translation.x, y: myView.center.y + translation.y)
            gesture.setTranslation(.zero, in: view)
        case .ended, .possible, .cancelled, .failed:
            animation.addBehavior(snapBehavior)
        default:
            break
            
        }
    }
}

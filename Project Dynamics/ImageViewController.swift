//
//  ImageViewController.swift
//  Project Dynamics
//
//  Created by Гранченко Максим on 1/11/19.
//  Copyright © 2019 Гранченко Максим. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    private var myView = UIView()
    private var nameLabel = UILabel()
    private var button = UIButton()
    private var animation: UIDynamicAnimator!
    private var snapBehavior: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView()
        
        animation = UIDynamicAnimator(referenceView: view)
        snapBehavior = UISnapBehavior(item: myView, snapTo: view.center)
        animation.addBehavior(snapBehavior)
        
        createPanGesture()
        createLabel()
        createButtonAndConstraints()
    }
    
    fileprivate func createLabel() {
        nameLabel.text = "SnapBehavior - Animation\n I like this Town"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.layer.shadowColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
        nameLabel.layer.shadowRadius = 8
        nameLabel.layer.shadowOpacity = 2
        nameLabel.layer.shadowOffset = CGSize(width: 2, height: 4)
        
        view.addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
    }
    
    fileprivate func createButtonAndConstraints() {
        button.setTitle("Scale Photo", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 1.5, height: 3)
        button.layer.cornerRadius = 18
        button.clipsToBounds = false
        button.layer.shouldRasterize = false
        button.addTarget(self, action: #selector(handleImageView), for: .touchUpInside)
        view.addSubview(button)
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        button.widthAnchor.constraint(equalTo: myView.widthAnchor, multiplier: 1).isActive = true
        button.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
    }
    
    fileprivate func createView() {
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
    }
    
    fileprivate func createPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        myView.isUserInteractionEnabled = true
        myView.addGestureRecognizer(pan)
    }
    
    @objc private func handleImageView() {
        UIView.animate(withDuration: 2, animations: {
            self.myView.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
        UIView.animate(withDuration: 5, animations: {
            self.myView.transform = .identity
        })
    }
    
    
    @objc fileprivate func handlePanGesture(gesture: UIPanGestureRecognizer) {
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

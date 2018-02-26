//
//  ViewController.swift
//  CarGame
//
//  Created by Hamza Ar on 24/02/2018.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

//This protocol explains what actions this delegate will involve.
protocol subviewDelegate {
    func changeSomething()
}

class ViewController: UIViewController, subviewDelegate{
    
    //Images variables
    @IBOutlet weak var roadImages: UIImageView!
    @IBOutlet weak var player: DraggedCarView!
    var obstacleCars = UIImageView(image: nil)
    

    //Behaviour variables
    var dynamicAnimator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    var dynamicItemBehavior: UIDynamicItemBehavior!

    func changeSomething() {
        collisionBehavior.removeAllBoundaries()
        //make the frame of the player car to the collision boundry of the obstacle car
        collisionBehavior.addBoundary(withIdentifier: "barrier" as
            NSCopying, for: UIBezierPath(rect: player.frame))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign viewController.swift as the delegate for the flower image view
        player.myDelegate = self
        
        //Create an array
        //and add all the road images to it
        var imageArray: [UIImage]!
        imageArray = [UIImage(named: "road1.png")!,
                      UIImage(named: "road2.png")!,
                      UIImage(named: "road3.png")!,
                      UIImage(named: "road4.png")!,
                      UIImage(named: "road5.png")!,
                      UIImage(named: "road6.png")!,
                      UIImage(named: "road7.png")!,
                      UIImage(named: "road8.png")!,
                      UIImage(named: "road9.png")!,
                      UIImage(named: "road10.png")!,
                      UIImage(named: "road11.png")!,
                      UIImage(named: "road12.png")!,
                      UIImage(named: "road13.png")!,
                      UIImage(named: "road14.png")!,
                      UIImage(named: "road15.png")!,
                      UIImage(named: "road16.png")!,
                      UIImage(named: "road17.png")!,
                      UIImage(named: "road18.png")!,
                      UIImage(named: "road19.png")!,
                      UIImage(named: "road20.png")!]
        
        //animate the road images
        roadImages?.image = UIImage.animatedImage(with: imageArray, duration: 0.5)
        
        //START > Behaviour code
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        //add the obstacle car to the UI
        obstacleCars.image = UIImage(named: "car1")
        obstacleCars.frame = CGRect(x: 118, y: -25, width: 30, height: 50)
        self.view.addSubview(obstacleCars)
    
        //Make the obstacle car move down
        dynamicItemBehavior = UIDynamicItemBehavior(items: [obstacleCars])
        self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: 0, y: 170), for: obstacleCars)
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        
        //add items to the collision behaviour
        collisionBehavior = UICollisionBehavior(items: [obstacleCars])
        
        //make the frame of the player car to the collision boundry of the obstacle car
        collisionBehavior.addBoundary(withIdentifier: "barrier" as
            NSCopying, for: UIBezierPath(rect: player.frame))
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        //add the behaviour to the dynamic animator 
        dynamicAnimator.addBehavior(collisionBehavior)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

///////////////////////////////////////////////////////////////////////////////
////Create a new UIImageView from scratch
//let carView = UIImageView(image: nil)
//
////Assign an image to the image view
//carView.image = UIImage(named: "car1.png")
//
////Assign the size and position of the image view
//carView.frame = CGRect(x:100, y: 100, width: 30, height: 50)
//
//self.view.addSubview(carView)

//let random = Int(arc4random_uniform(UInt32(self.view.bounds.width)))


//
//        var obstacleCarArray: [UIImage]!
//            obstacleCarArray = [UIImage(named: "car1.png")!,
//                                UIImage(named: "car2.png")!,
//                                UIImage(named: "car3.png")!,
//                                UIImage(named: "car4.png")!,
//                                UIImage(named: "car5.png")!,
//                                UIImage(named: "car6.png")!]


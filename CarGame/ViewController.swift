//
//  ViewController.swift
//  CarGame
//
//  Created by Hamza Ar on 24/02/2018.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Foundation

//This protocol explains what actions this delegate will involve.
protocol subviewDelegate {
    func changeSomething()
}

class ViewController: UIViewController, subviewDelegate{
    var timer = Timer()
    
    //Images variables
    @IBOutlet weak var roadImages: UIImageView!
    @IBOutlet weak var player: DraggedCarView!
    
    
    //display score and score variable
    @IBOutlet weak var displayScore: UILabel!
  
    let over = UIImageView(image: nil)
    let button = UIButton(frame: CGRect(x: 220, y: 470, width: 100, height: 50))
    
    //obstacle cars variables
    var obstacleCars: [UIImage]!
    var passedCars: [UIImageView] = []
    
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

        //Assign viewController.swift as the delegate for the car image view
        player.myDelegate = self
        
        obstacleCars = [UIImage(named: "car1.png")!,
                        UIImage(named: "car2.png")!,
                        UIImage(named: "car3.png")!,
                        UIImage(named: "car4.png")!,
                        UIImage(named: "car5.png")!,
                        UIImage(named: "car6.png")!]
        
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
        roadImages?.image = UIImage.animatedImage(with: imageArray, duration: 0.4)
        
    
        let date = Date().addingTimeInterval(0.5)
        timer = Timer(fireAt: date, interval: 1.7, target: self, selector: #selector(getCar), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
        startTime()
        
        
        //START > Behaviour code
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicItemBehavior = UIDynamicItemBehavior()
        collisionBehavior = UICollisionBehavior()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTime() -> Void {
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.gameOver()
        }
    }
    
    
    @objc func getCar() -> Void {
        
        
        let many = Int(arc4random_uniform(3))
        //Randomely select how many cars will appear at the same time out of three
        for _ in 0...many {
            
            //add all the obstacles cars to the display
            let oCar = UIImageView(image: nil)
            let random = Int(arc4random_uniform(UInt32(243))) + 53
            let c = Int(arc4random_uniform(6))
            oCar.image = obstacleCars[c]
            oCar.frame = CGRect(x: random, y: 0, width: 30, height: 50)
            self.view.addSubview(oCar)
            
            passedCars.append(oCar)
   
            dynamicItemBehavior.addItem(oCar)
            
            //Make the obstacle cars move down
            let speed = Int(arc4random_uniform(140)) + 120
            dynamicItemBehavior.addLinearVelocity(CGPoint(x: 0, y: speed), for: oCar)
            dynamicAnimator.addBehavior(dynamicItemBehavior)
            
            collisionBehavior.addItem(oCar)
            
            //add the behaviour to the dynamic animator
            dynamicAnimator.addBehavior(collisionBehavior)
            
        }
        
        }
    
    func gameOver() -> Void {
        timer.invalidate() //Stop the loop that calls the getCar function
        timer.invalidate()
        over.image = UIImage(named: "game_over.jpg")
        over.frame = UIScreen.main.bounds
        self.view.addSubview(over)

        self.view.bringSubview(toFront: over)

        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: UIControlState.normal)
        button.setTitle("Play Again", for: [])
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        over.removeFromSuperview()
        button.removeFromSuperview()
        for view in passedCars {
            view.removeFromSuperview()
        }
        passedCars = []
        startTime()
        let date = Date().addingTimeInterval(0.5)
        timer = Timer(fireAt: date, interval: 1.7, target: self, selector: #selector(getCar), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
       
    }
    
}


//
//  ViewController.swift
//  CarGame
//
//  Created by Hamza Ar on 24/02/2018.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

//This protocol explains what actions this delegate will involve.
protocol subviewDelegate {
    func changeSomething()
}

class ViewController: UIViewController, subviewDelegate{
    var manArray: [UIImage]!
    
    let bt = UIImageView(image: nil)
    let boss = UIImageView(image: nil)
    
    
    //Make time global
    var timer = Timer()
    var timer2 = Timer()
    
    //Crash sound variable
    var crashSound: AVAudioPlayer?
    
    //Images variables
    @IBOutlet weak var roadImages: UIImageView!
    @IBOutlet weak var player: DraggedCarView!
    
    
    //display score and score variable
    @IBOutlet weak var displayScore: UILabel!
    var score = 0
    
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
        
        //Make the score color white
        displayScore.textColor = .white
        
        //Go through the passed cars and if it inersects with player car then score-1
        //else if it crosses the botton screen then score+1
        for view in passedCars {
            if (view.frame.intersects(player.frame)) {
                score = score - 1
                
                let path = Bundle.main.path(forResource: "carCrash.mp3", ofType:nil)!
                let url = URL(fileURLWithPath: path)
                do {
                    crashSound = try AVAudioPlayer(contentsOf: url)
                    crashSound?.play()
                } catch {
                    // couldn't load file :(
                }
                
            } else {
                if view.center.y > UIScreen.main.bounds.height - 5 &&
                    view.center.y < UIScreen.main.bounds.height + 5 {
                    score = score + 1
                    
                }
            }
            //Display score
            displayScore.text = "$"+String(score)

        }
        
   
        
        //if is player is hit by bomb, then game over
        if bt.frame.intersects(player.frame) {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "GameOver")
            self.show(secondViewController!, sender: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign viewController.swift as the delegate for the car image view
        player.myDelegate = self
        
        //Array with all the obstacles
        obstacleCars = [UIImage(named: "car1.png")!,
                        UIImage(named: "car2.png")!,
                        UIImage(named: "car3.png")!,
                        UIImage(named: "car4.png")!,
                        UIImage(named: "car5.png")!,
                        UIImage(named: "car6.png")!,
                        UIImage(named: "car7.png")!,
                        UIImage(named: "car8.png")!,
                        UIImage(named: "car9.png")!]
        
        
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
        roadImages?.image = UIImage.animatedImage(with: imageArray, duration: 1.5)
        
        manArray = [UIImage(named: "man1.png")!,
                    UIImage(named: "man2.png")!,
                    UIImage(named: "man3.png")!,
                    UIImage(named: "man4.png")!]
        
        //animate the man array images
        player?.image = UIImage.animatedImage(with: manArray, duration: 0.4)
        
        startGame()

        //START > Behaviour code
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicItemBehavior = UIDynamicItemBehavior()
        collisionBehavior = UICollisionBehavior()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //when the timer ends, gameOver func will be called
    func startTime() -> Void {
        let when = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: when) {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "GameOver")
            self.show(secondViewController!, sender: nil)
        }
        
        
    
    }
    
    //start the game
    @objc func startGame() -> Void {
        
        //Timer loop, which calls the getCar() func every 1.7 secs
        let date = Date().addingTimeInterval(0.5)
        timer = Timer(fireAt: date, interval: 1.7, target: self, selector: #selector(getCar), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
        //Start the timer for game over
        startTime()
        
        let when = DispatchTime.now() + 6
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.bosss()
            
        }
        
        

    }
    
    func bosss() -> Void {
        self.boss.image = UIImage(named: "rocketMan.png")
        let random = Int(arc4random_uniform(UInt32(243))) + 53
        self.boss.frame = CGRect(x: random, y: 10, width: 55, height: 66)
        self.view.addSubview(self.boss)
        
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.bt.image = UIImage(named: "bullet.png")
            self.bt.frame = CGRect(x: random, y: 15, width: 16, height: 29)
            self.view.addSubview(self.bt)
            
            
            self.dynamicItemBehavior.addItem(self.bt)
            self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: 0, y: 180), for: self.bt)
            self.dynamicAnimator.addBehavior(self.dynamicItemBehavior)
            
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.boss.removeFromSuperview()
            }
            
            
        }
        
    
    }
    
    
    @objc func getCar() -> Void {
        let many = Int(arc4random_uniform(3))
        
        //Randomely select how many cars will appear at the same time out of three
        for _ in 0...many {
            
            //choose a random obstacle car and
            //add the obstacle car to the display
            let oCar = UIImageView(image: nil)
            let random = Int(arc4random_uniform(UInt32(243))) + 53
            let c = Int(arc4random_uniform(6))
            oCar.image = obstacleCars[c]
            oCar.frame = CGRect(x: random, y: 0, width: 30, height: 50)
            self.view.addSubview(oCar)
            
            //append the obstacel car to the passedCars array
            //which will be used later
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
    
}


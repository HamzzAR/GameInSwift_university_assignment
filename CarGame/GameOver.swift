//
//  GameOver.swift
//  CarGame
//
//  Created by Hamza Ar on 19/04/2018.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import AVFoundation

class GameOver: UIViewController{
    
    @IBOutlet weak var replatBtn: UIImageView!
    var die: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "dead.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            die = try AVAudioPlayer(contentsOf: url)
            die?.play()
        } catch {}
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
        replatBtn.addGestureRecognizer(tap1)
        replatBtn.isUserInteractionEnabled = true
        
    }
    
    //when the play again button is pressed
    //remove game over image from the superview
    //remove the play again button from the superview
    //remove all the cars from the superview
    //reset the passed cars array
    //reset the timer loop
    @objc func buttonAction() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
        self.show(secondViewController!, sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

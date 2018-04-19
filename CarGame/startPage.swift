//
//  startScreen.swift
//  CarGame
//
//  Created by Hamza Ar on 19/04/2018.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import AVFoundation

class startPage: UIViewController{
    
    @IBOutlet weak var startBtn: UIImageView!
    var gta: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAudio()
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
        startBtn.addGestureRecognizer(tap1)
        startBtn.isUserInteractionEnabled = true
        self.view.bringSubview(toFront: startBtn)
        
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
    
    func playAudio() {
        let path = Bundle.main.path(forResource: "san.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            gta = try AVAudioPlayer(contentsOf: url)
            gta?.play()
        } catch {}
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

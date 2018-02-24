//
//  DraggedCarView.swift
//  CarGame
//
//  Created by Hamza Ar on 24/02/2018.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class DraggedCarView: UIImageView {
    
    //global variable
    var startLocation = CGPoint(x: 0, y: 0)
    
    //when touches begin, record the touch's beginning
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        startLocation = (touches.first?.location(in: self))!
        
    }
    
    //when the touch moves, find the coodinate of the current touch
    //and set the center position  the image
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentLocation = touches.first?.location(in: self)
        let dx = currentLocation!.x - (startLocation.x)
        let dy = currentLocation!.y - (startLocation.y)
        
        //restrict car on x axes
        let cx = constraintX(dx: dx)
        
        //restrict car on the y axes
        let cy = constraintY(dy: dy)
    
        self.center = CGPoint(x: CGFloat(cx), y: CGFloat(cy))
        
    }
    
    //restricting car to not cross right or left screen boundry (x axes)
    func constraintX(dx:CGFloat) -> Float {
        let screenSize = UIScreen.main.bounds
        
        var cx = self.center.x+dx
        if (cx > screenSize.width - 30 ) {
            cx = screenSize.width - 30
        }
        if (cx < (0 + 30)) {
            cx = 0+30
        }
        
        return Float(cx)
    }
    
    //restricting car to not cross bottom or
    //top certian part of the screen boundry (y axes)
    func constraintY(dy:CGFloat) -> Float {
        let screenSize = UIScreen.main.bounds
        
        var cy = self.center.y+dy
        if (cy > screenSize.height - 60) {
            cy = screenSize.height - 60
        }
        if (cy < 0 + 230) {
            cy = 0 + 230
        }
        
        return Float(cy)
    }

}

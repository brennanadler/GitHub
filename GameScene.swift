//
//  GameScene.swift
//  GitHub
//
//  Created by Brennan Adler on 1/20/15.
//  Copyright (c) 2015 Brennan Adler and Sean Rayment. All rights reserved.
//  This will now appear on Brennan's computer

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //initialize
    
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

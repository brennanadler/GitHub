//
//  OptionMenu.swift
//  GitHub
//
//  Created by Brennan Adler on 4/18/15.
//  Copyright (c) 2015 Brennan Adler. All rights reserved.
//

import SpriteKit


class OptionMenu: SKScene
{
    var Screen: SKSpriteNode!
    let xScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("xScale"))
    let yScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("yScale"))
    
    override func didMoveToView(view: SKView)
    {
        Screen = SKSpriteNode()
        self.addChild(Screen)
        addBg()
    }
    
    func addBg(){
        let MainMenu = SKSpriteNode(imageNamed: "MainMenu")
        MainMenu.position = CGPointMake(frame.width / 2, frame.height / 2)
        addChild(MainMenu)
        
    }
    
    
    
}

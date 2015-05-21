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
    var ExitButton1: SKSpriteNode!
    let xScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("xScale"))
    let yScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("yScale"))
    
    let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
    
    override func didMoveToView(view: SKView)
    {
        Screen = SKSpriteNode()
        self.addChild(Screen)
        addBg(view)
    }
    
    func addBg(view:SKView){
        let MainMenu = SKSpriteNode(imageNamed: "MainMenu")
        MainMenu.position = CGPointMake(frame.width / 2, frame.height / 2)
        MainMenu.xScale = xScaler
        MainMenu.yScale = yScaler
        MainMenu.name = "bg"
        addChild(MainMenu)
        
        ExitButton1 = SKSpriteNode(texture: heroAtlas.textureNamed("ExitButton"))
        ExitButton1.position = CGPointMake(view.bounds.width * (22/23), view.bounds.height * (19/20))
        ExitButton1.name = "ExitButton1"
        ExitButton1.xScale = xScaler
        ExitButton1.yScale = xScaler
        Screen.addChild(ExitButton1)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        
        
        for touch: AnyObject in touches
        {
            
            let location = touch.locationInNode(self)
            var sprites = nodesAtPoint(location)
            
            for sprite in sprites
            {
                if let spriteNode = sprite as? SKSpriteNode
                {
                    if spriteNode.name != nil
                    {
                        if spriteNode.name == "ExitButton1"
                        {
                            let scene = MainMenu()
                            // Configure the view.
                            let skView = self.view as SKView!
                            skView.showsFPS = true
                            skView.showsNodeCount = true
                            
                            /* Sprite Kit applies additional optimizations to improve rendering performance */
                            skView.ignoresSiblingOrder = true
                            
                            /* Set the scale mode to scale to fit the window */
                            scene.scaleMode = .AspectFill
                            scene.size = skView.bounds.size
                            
                            skView.presentScene(scene)
                        }
                    }
                }
            }
        }
    }

}


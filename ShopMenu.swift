//
//  ShopMenu.swift
//  GitHub
//
//  Created by Brennan Adler on 4/18/15.
//  Copyright (c) 2015 Brennan Adler. All rights reserved.
//

import SpriteKit


class ShopMenu: SKScene
{
    var Screen: SKSpriteNode!
    var ShopButton1: SKSpriteNode!
    var ShopButton2: SKSpriteNode!
    var ShopButton3: SKSpriteNode!
    let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
    let xScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("xScale"))
    let yScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("yScale"))
    
    override func didMoveToView(view: SKView)
    {
        Screen = SKSpriteNode()
        self.addChild(Screen)
        addBg(view)
    }
    
    func addBg(view: SKView){
        
        ShopButton1 = SKSpriteNode(texture: heroAtlas.textureNamed("ShopButton"))
        ShopButton1.position = CGPointMake(view.bounds.width/6, view.bounds.height/2)
        ShopButton1.name = "ShopButton1"
        ShopButton1.xScale = xScaler
        ShopButton1.yScale = yScaler
        Screen.addChild(ShopButton1)
        
        ShopButton2 = SKSpriteNode(texture: heroAtlas.textureNamed("ShopButton"))
        ShopButton2.position = CGPointMake(view.bounds.width/2, view.bounds.height/2)
        ShopButton2.name = "ShopButton2"
        ShopButton2.xScale = xScaler
        ShopButton2.yScale = yScaler
        Screen.addChild(ShopButton2)
        
        ShopButton3 = SKSpriteNode(texture: heroAtlas.textureNamed("ShopButton"))
        ShopButton3.position = CGPointMake(view.bounds.width * (5/6), view.bounds.height/2)
        ShopButton3.name = "ShopButton3"
        ShopButton3.xScale = xScaler
        ShopButton3.yScale = yScaler
        Screen.addChild(ShopButton3)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
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
                        if spriteNode.name == "ShopButton1"
                        {
                            deleteButtons()
                        }else if spriteNode.name == "ShopButton2"
                        {
                            deleteButtons()
                        }else if spriteNode.name == "ShopButton3"
                        {
                            deleteButtons()
                        }
                    }
                }
            }
        }
    }

    func deleteButtons(){
        ShopButton1.removeFromParent()
        ShopButton2.removeFromParent()
        ShopButton3.removeFromParent()
    }
    
    
    
}

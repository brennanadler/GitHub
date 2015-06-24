    //
    //  ShopMenu.swift
    //  GitHub
    //
    //  Created by Brennan Adler on 4/18/15.
    //  Copyright (c) 2015 Brennan Adler. All rights reserved.
    //
    
    import SpriteKit
    
    
    class ShoppingMenu: SKScene
    {
        var Screen: SKSpriteNode!
        var ShopButton1: SKSpriteNode!
        var ShopButton2: SKSpriteNode!
        var ShopButton3: SKSpriteNode!
        var ExitButton1: SKSpriteNode!
        var BackButton1: SKSpriteNode!
        var Fireskin: SKSpriteNode!
        var DefaultSkin:SKSpriteNode!
        var Price: UITextView!
        var Price1: UITextView!
        var GemCount: Int = NSUserDefaults.standardUserDefaults().integerForKey("Gems")
        
        //variables for the gem counter at the bottom
        var gem: SKSpriteNode!
        var gemDefault: SKSpriteNode!
        var GemBoard: UITextView!
        
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
            
            ExitButton1 = SKSpriteNode( texture: heroAtlas.textureNamed("ExitButton"))
            ExitButton1.position = CGPointMake(view.bounds.width * (22/23), view.bounds.height * (19/20))
            ExitButton1.name = "ExitButton1"
            ExitButton1.xScale = xScaler
            ExitButton1.yScale = xScaler
            Screen.addChild(ExitButton1)
            
            
            
            gem = SKSpriteNode(texture: heroAtlas.textureNamed("Gem"))
            gem.position = CGPointMake(view.bounds.width * (1/30), view.bounds.height/16)
            gem.xScale = xScaler
            gem.yScale = yScaler
            Screen.addChild(gem)
            
            GemBoard = UITextView(frame: CGRect(x: view.bounds.width / 15, y: view.bounds.height * (59/64), width: 300, height: 20))
            GemBoard.editable = false
            GemBoard.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
            GemBoard.textColor = UIColor.greenColor()
            let Gemcount = NSUserDefaults.standardUserDefaults().integerForKey("Gems")
            GemBoard.text = "\(Gemcount)"
            view.addSubview(GemBoard)
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
                            if spriteNode.name == "ShopButton1"
                            {
                                deleteButtons()
                                skins()
                            }else if spriteNode.name == "ShopButton2"
                            {
                                deleteButtons()
                            }else if spriteNode.name == "ShopButton3"
                            {
                                deleteButtons()
                            }else if spriteNode.name == "ExitButton1"
                            {
                                returntoMain()
                            }else if spriteNode.name == "BackButton1"
                            {
                                backtoshop()
                            }else if spriteNode.name == "FireSkin"
                            {
                                buySkin("2", skinValue: 100)
                            }else if spriteNode.name == "DefaultSkin"
                            {
                                buySkin("1", skinValue: 0)
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
            
            BackButton1 = SKSpriteNode( texture: heroAtlas.textureNamed("return"))
            BackButton1.position = CGPointMake(view!.bounds.width * (1/14), view!.bounds.height * (19/20))
            BackButton1.name = "BackButton1"
            BackButton1.xScale =  xScaler
            BackButton1.yScale =  xScaler
            Screen.addChild(BackButton1)
        }
        
        func returntoMain(){
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
            
            GemBoard.removeFromSuperview()
            scene.updateHScore(0)
            
            if(Price != nil){
                Price.removeFromSuperview()
                Price1.removeFromSuperview()
            }

            skView.presentScene(scene)
            
            
        }
        
        func backtoshop(){
            
            let scene = ShoppingMenu()
            // Configure the view.
            let skView = self.view as SKView!
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.size = skView.bounds.size
            
            if(Price != nil){
                Price.removeFromSuperview()
                Price1.removeFromSuperview()
            }
            
            GemBoard.removeFromSuperview()
            skView.presentScene(scene)
            
        }
        
        //adds skins visibly to screen
        func skins(){
            
            if let skinnerSet = NSUserDefaults.standardUserDefaults().dictionaryForKey("skins"){

                Fireskin = SKSpriteNode( texture: heroAtlas.textureNamed("10Xmini_wizard_2"))
                Fireskin.position = CGPointMake(view!.bounds.width * (1/2), view!.bounds.height * (4/5))
                Fireskin.name = "FireSkin"
                Fireskin.xScale = 0.3 * xScaler
                Fireskin.yScale = 0.3 * xScaler
                Screen.addChild(Fireskin)
                
                let fireSkinID: String = "2"
                let isFireBought: Int = skinnerSet[fireSkinID]! as! Int
                
                if(isFireBought == 0){
                    gemDefault = SKSpriteNode(texture: heroAtlas.textureNamed("Gem"))
                    gemDefault.position = CGPointMake(self.view!.bounds.width * (47/100), self.view!.bounds.height * (63/100))
                    gemDefault.xScale = xScaler
                    gemDefault.yScale = yScaler
                    Screen.addChild(gemDefault)
                    
                    Price = UITextView(frame: CGRect(x: view!.bounds.width * (50/100), y: view!.bounds.height * (35/100), width: 300, height: 20))
                    Price.text = "100"
                    Price.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
                    Price.textColor = UIColor.greenColor()
                    Price.editable = false
                    view!.addSubview(Price)
                }else{
                    Price = UITextView(frame: CGRect(x: view!.bounds.width * (45/100), y: view!.bounds.height * (35/100), width: 300, height: 20))
                    Price.editable = false
                    Price.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
                    Price.textColor = UIColor.greenColor()
                    Price.text = "Owned"
                    view!.addSubview(Price)
                }
                
                
            }else{
                
            }
            
            
            
            DefaultSkin = SKSpriteNode( texture: heroAtlas.textureNamed("10Xmini_wizard_1"))
            DefaultSkin.position = CGPointMake(view!.bounds.width * (25/100), view!.bounds.height * (80/100))
            DefaultSkin.name = "DefaultSkin"
            DefaultSkin.xScale = 0.3 * xScaler
            DefaultSkin.yScale = 0.3 * xScaler
            Screen.addChild(DefaultSkin)
            
            
            Price1 = UITextView(frame: CGRect(x: view!.bounds.width * (20/100), y: view!.bounds.height * (35/100), width: 300, height: 20))
            Price1.editable = false
            Price1.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
            Price1.textColor = UIColor.greenColor()
            Price1.text = "Owned"
            view!.addSubview(Price1)
            
            
        }
        
        func buySkin(skinType:String, skinValue:Int){

            
            if var skinSet = NSUserDefaults.standardUserDefaults().dictionaryForKey("skins")
            {

                if(skinSet[skinType]! as! NSObject == 0)
                {
                    println("you bought \(skinType)")
                    
                    //charge user
                    if(GemCount >= skinValue)
                    {
                        GemCount = GemCount - skinValue
                        NSUserDefaults.standardUserDefaults().setInteger(GemCount, forKey: "Gems")
                        GemBoard.text = ("\(GemCount)")
                        
                        //update that user bought this
                        skinSet[skinType] = 1
                        NSUserDefaults.standardUserDefaults().setObject(skinSet, forKey: "skins")
                        
                        //code for texture
                        NSUserDefaults.standardUserDefaults().setObject("_\(skinType)", forKey: "SkinSuffix")
                        
                        //update the purchased thing
                        Price.removeFromSuperview()
                        Price = UITextView(frame: CGRect(x: view!.bounds.width * (45/100), y: view!.bounds.height * (35/100), width: 300, height: 20))
                        Price.editable = false
                        Price.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
                        Price.textColor = UIColor.greenColor()
                        Price.text = "Owned"
                        view!.addSubview(Price)
                        gemDefault.removeFromParent()
                        
                    }else
                    {
                        println("you are broke")
                    }
                }else{
                    println("already owned")
                    NSUserDefaults.standardUserDefaults().setObject("_\(skinType)", forKey: "SkinSuffix")
                }
                

   
            
        }


    }
    
}
    
    

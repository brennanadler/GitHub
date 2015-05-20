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
        var Price: UITextField!
        var FireskinBought: Int!
        var GemCount: Int = NSUserDefaults.standardUserDefaults().integerForKey("Gems")
        
        //variables for the gem counter at the bottom
        var gem: SKSpriteNode!
        var GemBoard: UITextField!
        
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
            
            GemBoard = UITextField(frame: CGRect(x: view.bounds.width / 15, y: view.bounds.height * (59/64), width: 300, height: 20))
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
                            }else if spriteNode.name == "Fireskin"
                            {
                                buyFireSkin()
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
            println("This")
            
            GemBoard.removeFromSuperview()
            scene.updateHScore(0)
            
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
            GemBoard.removeFromSuperview()
            
            
            skView.presentScene(scene)
            
        }
        
        func skins(){
            
            Fireskin = SKSpriteNode( texture: heroAtlas.textureNamed("10Xmini_wizard_1"))
            Fireskin.position = CGPointMake(view!.bounds.width * (1/2), view!.bounds.height * (2/3))
            Fireskin.name = "Fireskin"
            Fireskin.xScale = 0.3 * xScaler
            Fireskin.yScale = 0.3 * xScaler
            Screen.addChild(Fireskin)
            
            gem = SKSpriteNode(texture: heroAtlas.textureNamed("Gem"))
            gem.position = CGPointMake(view!.bounds.width * (14/30), view!.bounds.height * (10/30))
            gem.xScale = xScaler
            gem.yScale = yScaler
            Screen.addChild(gem)
            
            Price = UITextField(frame: CGRect(x: view!.bounds.width * (16/30), y: view!.bounds.height * (18/30), width: 300, height: 20))
            Price.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
            Price.textColor = UIColor.greenColor()
            Price.text = "100"
            view!.addSubview(Price)
            
            
        }
        
        func buyFireSkin(){
            FireskinBought = NSUserDefaults.standardUserDefaults().integerForKey("fireIsBought")
            if(FireskinBought == 1){
                NSUserDefaults.standardUserDefaults()
                
            }else{
                if(GemCount >= 100){
                GemCount = GemCount - 100
                NSUserDefaults.standardUserDefaults().setInteger(GemCount, forKey: "Gems")
                    NSUserDefaults.standardUserDefaults()
                }
            }
            
            
            
        }
        
        deinit{
            GemBoard.removeFromSuperview()
        }
    }
    
    
    
    

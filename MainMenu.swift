//
//  MainMenu.swift
//  GitHub
//
//  Created by Brennan Adler on 4/17/15.
//  Copyright (c) 2015 Brennan Adler. All rights reserved.
//

import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class MainMenu: SKScene
{
    let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
    var Screen: SKSpriteNode!
    var ScoreBoarder: UITextField!
    var HighScoreBoard: UITextField!
    var PreviousScore: Int!
    var Game = false
    let xScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("xScale"))
    let yScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("yScale"))
    
    
    override func didMoveToView(view: SKView)
    {
        Screen = SKSpriteNode()
        self.addChild(Screen)
        addBackground()
        addStartButton()
        addOptionButton()
        addStoreButton()
        addHighScore()
        addScoreBoard()

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
                        // Configure the view.
                        let skView = self.view as SKView!
                        skView.showsFPS = true
                        skView.showsNodeCount = true
                        if spriteNode.name == "StartButton"
                        {
            
                            
                            /* Sprite Kit applies additional optimizations to improve rendering performance */
                            
                            //sets ignoreSiblingOrder to false the first game because of XCode Glitch where background was rendering over player for some reason
                            skView.ignoresSiblingOrder = false
                            if(Game){
                                skView.ignoresSiblingOrder = true
                            }
                            
                            if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
                            {
                                skView.presentScene(scene)
                                /* Set the scale mode to scale to fit the window */
                                scene.scaleMode = .AspectFill

                            }
                            
                        }else if(spriteNode.name == "OptionButton"){
                            
                            let scenery = OptionMenu()
                            scenery.scaleMode = .AspectFill
                            scenery.size = skView.bounds.size
                            skView.presentScene(scenery)
                            /* Set the scale mode to scale to fit the window */

                            
                        }else if(spriteNode.name == "ShopButton"){
                            
                            let scene = ShopMenu()
                            scene.scaleMode = .AspectFill
                            scene.size = skView.bounds.size
                            skView.presentScene(scene)
                            /* Set the scale mode to scale to fit the window */
                            
                        }
                        
                        ScoreBoarder.removeFromSuperview()
                        HighScoreBoard.removeFromSuperview()
                        
                    }
                }
            }
        }
    }
    
    func addBackground(){
        let MainMenu = SKSpriteNode(imageNamed: "MainMenu")
        MainMenu.position = CGPointMake(frame.width / 2, frame.height / 2)
        MainMenu.xScale = xScaler
        MainMenu.yScale = yScaler
        addChild(MainMenu)
    }
    
    func addStartButton(){
        var StartButton: SKSpriteNode!
        StartButton = SKSpriteNode(texture: heroAtlas.textureNamed("Start"))
        StartButton.position = CGPointMake(frame.width / 2, frame.height / 2.4)
        StartButton.name = "StartButton"
        StartButton.xScale = xScaler
        StartButton.yScale = yScaler
        addChild(StartButton)
    }
    
    func addOptionButton(){
        var OptionButton: SKSpriteNode!
        OptionButton = SKSpriteNode(texture: heroAtlas.textureNamed("Start"))
        OptionButton.position = CGPointMake(frame.width / 2, frame.height / 3.44)
        OptionButton.name = "OptionButton"
        OptionButton.xScale = xScaler
        OptionButton.yScale = yScaler
        addChild(OptionButton)
    }
    
    func addStoreButton(){
        var ShopButton: SKSpriteNode!
        ShopButton = SKSpriteNode(texture: heroAtlas.textureNamed("Start"))
        ShopButton.position = CGPointMake(frame.width / 2, frame.height / 6)
        ShopButton.name = "ShopButton"
        ShopButton.xScale = xScaler
        ShopButton.yScale = yScaler
        addChild(ShopButton)
    }
    func addHighScore(){
        
        HighScoreBoard = UITextField(frame: CGRect(x: 16, y: 26, width: 300, height: 20))
        HighScoreBoard.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
        
        //this variable draws from the permanent value created earlier for Highscore
        var HScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("HighScore")
        HighScoreBoard.text = "High Score: \(HScore)"
        HighScoreBoard.textColor = UIColor.blackColor()
        self.view?.addSubview(HighScoreBoard)
        
    }
    
    func addScoreBoard(){
        ScoreBoarder = UITextField(frame: CGRect(x: 520, y: 26, width: 300, height: 20))
        ScoreBoarder.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
        if(PreviousScore != nil){
            ScoreBoarder.text = "Previous: \(PreviousScore)"
        }
        ScoreBoarder.textColor = UIColor.blackColor()
        self.view?.addSubview(ScoreBoarder)
    }
    
    func updateHScore(PScore:Int){
        PreviousScore = PScore
        Game = true
        
        //takes previous HighScore Value and compares it to the previous score to see if a new highscore was set
        var preHScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("HighScore")
        if(PScore >  preHScore){
            
            //sets new highscore value
            NSUserDefaults.standardUserDefaults().setObject(PScore, forKey: "HighScore")

        }
        var Coin:Int = NSUserDefaults.standardUserDefaults().integerForKey("Coins")
        Coin = Coin + Int(PScore/1000)
        NSUserDefaults.standardUserDefaults().setInteger(Coin, forKey: "Coins")
        println(Coin)
    }
    
    
}

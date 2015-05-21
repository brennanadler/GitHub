//
//  MainMenu.swift
//  GitHub
//
//  Created by Brennan Adler on 4/17/15.
//  Copyright (c) 2015 Brennan Adler. All rights reserved.
//

import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
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
    
    //Scoreboard/highscore vars
    var ScoreBoarder: UITextField!
    var PreviousScore: Int!
    var HighScoreBoard: UITextField!
    
    //Gem variables
    var GemBoard: UITextField!
    var gem:SKSpriteNode!
    
    //Keeps track of whether the game has run at least once (So ads wont load immediately)
    var GameNumber: Int?

    //For cross platform (iPhone, iPad, etc.)
    let xScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("xScale"))
    let yScaler:CGFloat = CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("yScale"))
    
    
    override func didMoveToView(view: SKView)
    {
        Screen = SKSpriteNode()
        self.addChild(Screen)
        addBackground()
        addHighScore()
        addScoreBoard(view)
        addGemBoard(view)
        addStartButton()
        addOptionButton()
        addStoreButton()
        
        
        var randomnumber:UInt32 = 0
        
        var random = arc4random_uniform(randomnumber)
        
        if(GameNumber > 0){
            if((Int)(random) == 0){
                NSNotificationCenter.defaultCenter().postNotificationName("runadsID", object: nil)
            }
        }

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
                        // Configure the view.
                        let skView = self.view as SKView!
                        skView.showsFPS = true
                        skView.showsNodeCount = true
                        if spriteNode.name == "StartButton"
                        {
            
                            
                            /* Sprite Kit applies additional optimizations to improve rendering performance */
                            
                          
                            skView.ignoresSiblingOrder = true
                            
                            
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
                            
                            let sceneries = ShoppingMenu()
                            sceneries.scaleMode = .AspectFill
                            sceneries.size = skView.bounds.size
                            skView.presentScene(sceneries)
                            /* Set the scale mode to scale to fit the window */
                            
                        }
                        
                        ScoreBoarder.removeFromSuperview()
                        HighScoreBoard.removeFromSuperview()
                        gem.removeFromParent()
                        GemBoard.removeFromSuperview()
                        "removeGemFromMain"
                        
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
        MainMenu.zPosition = 3
        addChild(MainMenu)
    }
    
    func addStartButton(){
        var StartButton: SKSpriteNode!
        StartButton = SKSpriteNode(texture: heroAtlas.textureNamed("Start"))
        StartButton.position = CGPointMake(frame.width / 2, frame.height / 2.4)
        StartButton.name = "StartButton"
        StartButton.xScale = xScaler
        StartButton.yScale = yScaler
        StartButton.zPosition = 3
        addChild(StartButton)
    }
    
    func addOptionButton(){
        var OptionButton: SKSpriteNode!
        OptionButton = SKSpriteNode(texture: heroAtlas.textureNamed("Options"))
        OptionButton.position = CGPointMake(frame.width / 2, frame.height / 3.44)
        OptionButton.name = "OptionButton"
        OptionButton.xScale = xScaler
        OptionButton.yScale = yScaler
        OptionButton.zPosition = 3
        addChild(OptionButton)
    }
    
    func addStoreButton(){
        var ShopButton: SKSpriteNode!
        ShopButton = SKSpriteNode(texture: heroAtlas.textureNamed("Shop"))
        ShopButton.position = CGPointMake(frame.width / 2, frame.height / 6)
        ShopButton.name = "ShopButton"
        ShopButton.xScale = xScaler
        ShopButton.yScale = yScaler
        ShopButton.zPosition = 3
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
    
    func addScoreBoard(view:SKView){
        ScoreBoarder = UITextField(frame: CGRect(x: view.bounds.width / 1.3, y: 26, width: 300, height: 20))
        ScoreBoarder.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
        if(PreviousScore != nil){
            ScoreBoarder.text = "Previous: \(PreviousScore)"
        }
        ScoreBoarder.textColor = UIColor.blackColor()
        self.view?.addSubview(ScoreBoarder)
    }
    
    func addGemBoard(view: SKView){
        gem = SKSpriteNode(texture: heroAtlas.textureNamed("Gem"))
        gem.position = CGPointMake(view.bounds.width * (1/30), view.bounds.height/16)
        gem.xScale = xScaler
        gem.yScale = yScaler
        gem.zPosition = 3
        Screen.addChild(gem)
        
        GemBoard = UITextField(frame: CGRect(x: view.bounds.width / 15, y: view.bounds.height * (59/64), width: view.bounds.width / 2, height: 20))
        GemBoard.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 0.0)
        GemBoard.textColor = UIColor.greenColor()
        let Gemcount = NSUserDefaults.standardUserDefaults().integerForKey("Gems")
        GemBoard.text = "\(Gemcount)"
        view.addSubview(GemBoard)
    }
    func updateHScore(PScore:Int){
        PreviousScore = PScore

        
        //takes previous HighScore Value and compares it to the previous score to see if a new highscore was set
        var preHScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("HighScore")
        if(PScore >  preHScore){
            
            //sets new highscore value
            NSUserDefaults.standardUserDefaults().setObject(PScore, forKey: "HighScore")

        }
        var Gems:Int = NSUserDefaults.standardUserDefaults().integerForKey("Gems")
        Gems = Gems + Int(PScore/1000)
        NSUserDefaults.standardUserDefaults().setInteger(Gems, forKey: "Gems")
        
        GameNumber = 1
    }
    
    deinit {
        GameNumber = 1
        NSNotificationCenter.defaultCenter().postNotificationName("loadadsID", object: nil)
        GemBoard.removeFromSuperview()
    }
    
    
}

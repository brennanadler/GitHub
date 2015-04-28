//
//  MainMenu.swift
//  GitHub
//
//  Created by Brennan Adler on 4/17/15.
//  Copyright (c) 2015 Brennan Adler. All rights reserved.
//

import Foundation
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
    var Screen: SKNode!
    var Game = false
    var ScoreBoard: UITextField!
    
    
    override func didMoveToView(view: SKView)
    {
        Screen = SKNode()
        self.addChild(Screen)
        addBackground()
        addStartButton()
        addOptionButton()
        addStoreButton()
        //NSNotificationCenter.defaultCenter().postNotificationName("showadsID", object: nil)
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
                        
                        /* Sprite Kit applies additional optimizations to improve rendering performance */
                        skView.ignoresSiblingOrder = true
                        
                        if spriteNode.name == "StartButton"
                        {
        
                            if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
                            {
                                skView.presentScene(scene)
                                /* Set the scale mode to scale to fit the window */
                                scene.scaleMode = .AspectFill
                                
                                if(Game){
                                    ScoreBoard.removeFromSuperview()
                                }
                            }
                            
                        }else if(spriteNode.name == "OptionButton"){
                            
                            let scenery = OptionMenu()
                            skView.presentScene(scenery)
                            /* Set the scale mode to scale to fit the window */
                            scenery.scaleMode = .AspectFill
                            
                        }else if(spriteNode.name == "ShopButton"){
                            
                            let scene = ShopMenu()
                            skView.presentScene(scene)
                            /* Set the scale mode to scale to fit the window */
                            scene.scaleMode = .AspectFill
                            
                        }
                        
                    }
                }
            }
        }
    }
    
    func addBackground(){
        let MainMenu = SKSpriteNode(imageNamed: "MainMenu")
        MainMenu.xScale = 0.0015
        MainMenu.yScale = 0.0015
        MainMenu.position = CGPointMake(frame.width / 2, frame.height / 2)
        addChild(MainMenu)
    }
    
    func addStartButton(){
        var StartButton: SKSpriteNode!
        StartButton = SKSpriteNode(texture: heroAtlas.textureNamed("Start"))
        StartButton.position = CGPointMake(frame.width / 2, frame.height / 2.4)
        StartButton.name = "StartButton"
        StartButton.xScale = 0.0015
        StartButton.yScale = 0.0015
        addChild(StartButton)
    }
    
    func addOptionButton(){
        var OptionButton: SKSpriteNode!
        OptionButton = SKSpriteNode(texture: heroAtlas.textureNamed("Start"))
        OptionButton.position = CGPointMake(frame.width / 2, frame.height / 2.85)
        OptionButton.name = "OptionButton"
        OptionButton.xScale = 0.0015
        OptionButton.yScale = 0.0015
        addChild(OptionButton)
    }
    
    func addStoreButton(){
        var ShopButton: SKSpriteNode!
        ShopButton = SKSpriteNode(texture: heroAtlas.textureNamed("Start"))
        ShopButton.position = CGPointMake(frame.width / 2, frame.height / 3.5)
        ShopButton.name = "ShopButton"
        ShopButton.xScale = 0.0015
        ShopButton.yScale = 0.0015
        addChild(ShopButton)
    }
    
    func addScoreBoard(PScore: Int){
    ScoreBoard = UITextField(frame: CGRect(x: 520, y: 26, width: 300, height: 20))
    ScoreBoard.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 1.0)
    ScoreBoard.text = "Previous: \(PScore)"
    ScoreBoard.textColor = UIColor.blackColor()
    self.view?.addSubview(ScoreBoard)
    
        var preHScore: NSString = NSUserDefaults.standardUserDefaults().stringForKey("HighScore")!
        var preHScoreN: Int = preHScore.integerValue
        
        if(PScore >  preHScoreN){
            NSUserDefaults.standardUserDefaults().setObject("\(PScore)", forKey: "HighScore")
        }
        
        println("High Score \(preHScoreN)")
    
    }


}

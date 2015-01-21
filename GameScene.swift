import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
  // Our main scene. Everything is added to this for the playable game
  var TheGame: SKNode!
  
  // Our running man! Defaults to a stand still position
  let heroAtlas = SKTextureAtlas(named: "hero.atlas")
  var hero: SKSpriteNode!
  
  override func didMoveToView(view: SKView)
  {
    // setup physics/gravity WAITING TILL WE MAKE GROUND
    //self.physicsWorld.gravity = CGVectorMake(0.0, -2)
    
    TheGame = SKNode()
    self.addChild(TheGame)
    
    createSky()
    addJumpButton()
    
    //initializes our hero and sets his initial texture to running1
    hero = SKSpriteNode(texture: heroAtlas.textureNamed("running1"))
    hero.xScale = 0.5
    hero.yScale = 0.5
    hero.position = CGPointMake(frame.width / 2.5, frame.height / 4.0)
    
    // Enable physics around our hero using a circle to draw our radius
    //hero.physicsBody = SKPhysicsBody(circleOfRadius: hero.size.height / 2.75)
    //hero.physicsBody?.dynamic = true
    
    self.addChild(hero)
    runForward()
  }
  
   override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        
        for touch: AnyObject in touches
        {
            
            let location = touch.locationInNode(self)
            var sprites = nodesAtPoint(location)
            for sprite in sprites {
                if let spriteNode = sprite as? SKSpriteNode {
                    if spriteNode.name != nil {
                        if spriteNode.name == "jump" {
                            
                            // Do jump
                            let jumping = SKAction.animateWithTextures([
                                heroAtlas.textureNamed("running1"),
                                heroAtlas.textureNamed("running2"),
                                heroAtlas.textureNamed("running3"),
                                heroAtlas.textureNamed("jumping1"),
                                heroAtlas.textureNamed("jumping2")
                                ], timePerFrame: 0.06)
                            
                            let jump = SKAction.repeatAction(jumping, count: 1)
                            
                            if (hero.actionForKey("jumping") == nil)
                            {
                                hero.runAction(jump, withKey: "jumping")
                                hero.physicsBody?.velocity = CGVectorMake(0, 0)
                                hero.physicsBody?.applyImpulse(CGVectorMake(0, 200))
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
  func addJumpButton(){
    var jump: SKSpriteNode!
    jump = SKSpriteNode(imageNamed: "jumpButton")
    jump.position = CGPointMake(frame.width / 1.3, frame.height / 5.0)
    self.addChild(jump)
  }
  
  func runForward()
  {
    let hero_run_anim = SKAction.animateWithTextures([
      heroAtlas.textureNamed("running1"),
      heroAtlas.textureNamed("running2"),
      heroAtlas.textureNamed("running2")
      ], timePerFrame: 0.06)
    
    let run = SKAction.repeatActionForever(hero_run_anim)
    
    hero.runAction(run, withKey: "running")
  }
  
  func createSky()
  {
    let skyTexture = SKSpriteNode(color: UIColor(red: 71/255, green: 140/255, blue: 183/255, alpha: 1.0), size: frame.size)
    skyTexture.position = CGPointMake(frame.width / 2, frame.height / 2)
    TheGame.addChild(skyTexture)
  }
  
}

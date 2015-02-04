import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
    {
    
    var TheGame: SKNode!

    let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
    
    //Init SpritekitNodes
    var hero: SKSpriteNode!
    var manaBar: SKSpriteNode!
    
    
    //let manaAtlas = SKTextureAtlas(named: "mana.atlas")
    
 
    var mana:CGFloat!
    var maxMana:CGFloat!
    var manaPercent:CGFloat!
    var manaRegen:CGFloat!
    var manaSize: CGSize!
    var manaWidth: CGFloat!
    
    override func didMoveToView(view: SKView)
{
    // setup physics/gravity
    self.physicsWorld.gravity = CGVectorMake(0.0, -5)
    
    TheGame = SKNode()
    self.addChild(TheGame)
    
    createSky()
    createGround()
    addJumpButton()
    
    //initializes our hero and sets his initial texture to running1
    hero = SKSpriteNode(texture: heroAtlas.textureNamed("10Xmini_wizard"))
    hero.xScale = 0.5
    hero.yScale = 0.5
    hero.position = CGPointMake(frame.width / 4.0, frame.height / 4.0)
    
    hero.physicsBody = SKPhysicsBody(circleOfRadius: hero.size.height / 2.0)
    hero.physicsBody?.dynamic = true
    
    //init Mana Color
        mana = 50
        maxMana = 100
        manaPercent = 50
        manaRegen = 1
    
        manaWidth = manaPercent
        manaSize = CGSize(width: manaWidth, height: 20)
        manaBar = SKSpriteNode(color: UIColor(red: 255/255, green: 70/255, blue: 10/255, alpha: 1.0), size: manaSize)
        manaBar.position = CGPointMake(frame.width / 2.0, frame.height / 2.0)
        manaBar.physicsBody?.dynamic = false;
        self.addChild(manaBar);
        
        self.addChild(hero);
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
                            heroAtlas.textureNamed("10Xmini_wizard_running1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2"),
                            heroAtlas.textureNamed("mini_wizard_jumping2")
                            ], timePerFrame: 0.06)
    
                        let jump = SKAction.repeatAction(jumping, count: 1)
    
    
                        if (hero.actionForKey("jumping") == nil && mana > 80)
                        {
                            mana = mana - 70
                            hero.runAction(jump, withKey: "jumping")
                            hero.physicsBody?.velocity = CGVectorMake(0, 0)
                            hero.physicsBody?.applyImpulse(CGVectorMake(0, 500))
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
    jump.position = CGPointMake(frame.width / 1.1, frame.height / 5.0)
    jump.name = "jump"
    self.addChild(jump)
    }
    
    func runForward()
{
    let hero_run_anim = SKAction.animateWithTextures([
    heroAtlas.textureNamed("10Xmini_wizard_running1"),
    heroAtlas.textureNamed("10Xmini_wizard_running2")
    ], timePerFrame: 0.12)
    
    let run = SKAction.repeatActionForever(hero_run_anim)
    
    hero.runAction(run, withKey: "running")
        }
    func createGround()
    {
        let groundTexture = SKTexture(imageNamed: "bg")
        groundTexture.filteringMode = .Nearest
    
        let moveGroundSprite = SKAction.moveByX(-groundTexture.size().width * 2.0, y: 0, duration: NSTimeInterval(0.01 * groundTexture.size().width * 1.0))
        let resetGroundSprite = SKAction.moveByX(groundTexture.size().width * 2.0, y: 0, duration: 0.0)
        let moveGroundSpritesForever = SKAction.repeatActionForever(SKAction.sequence([moveGroundSprite, resetGroundSprite]))
    
        for var i:CGFloat = 0; i < 2.0 + self.frame.size.width / (groundTexture.size().width * 2.0); ++i
        {
            let sprite = SKSpriteNode(texture: groundTexture)
            sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: groundTexture.size().width, height: frame.height/8))
            sprite.physicsBody?.dynamic = false
            sprite.setScale(2.0)
            sprite.position = CGPointMake(i * sprite.size.width, sprite.size.height / 2.0)
            sprite.runAction(moveGroundSpritesForever)
            TheGame.addChild(sprite)
        }
    }
    
    func createSky()
    {
        let skyTexture = SKSpriteNode(color: UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 1.0), size: frame.size)
        skyTexture.position = CGPointMake(frame.width / 2, frame.height / 2)
        TheGame.addChild(skyTexture)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        updateManaBar()
    }
    
    //updates mana bar itself
    func updateManaBar(){
        calculateMana()
        manaWidth = manaPercent
        manaSize = CGSize(width: manaWidth, height: 20)
        manaBar.size = manaSize
        manaBar.position = CGPointMake(frame.width / 10, frame.height / 1.2)
        manaBar.physicsBody?.dynamic = false;
    }
    
    //calculates mana values
    func calculateMana(){
        
            mana = mana + manaRegen;
            if (mana > maxMana){
                mana = maxMana
            }else if (mana < 1){
                mana = 1
        }
            manaPercent = (mana/maxMana) * 100
        
    }
    
    
}

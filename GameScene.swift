import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var TheGame: SKNode!
    
    let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
    
    //Init SpritekitNodes
    var hero: SKSpriteNode!
    var manaOver: SKSpriteNode!
    var manaBar: SKSpriteNode!
    
    //mana variables
    var mana:CGFloat!
    var maxMana:CGFloat!
    var manaPercent:CGFloat!
    var manaRegen:CGFloat!
    var manaSize: CGSize!
    var manaWidth: CGFloat!
    
    var fireBallPoint: CGPoint!
    var point: CGPoint!
    
    var time: Int!
    var frames: Int!
    
    override func didMoveToView(view: SKView)
    {
        frames = 0
        time = 0
        
        // setup physics/gravity
        self.physicsWorld.gravity = CGVectorMake(0.0, -7)
        
        TheGame = SKNode()
        self.addChild(TheGame)
        
        createSky()
        createGround()
        addFireButton()
        addJumpButton()
        addManaOverlay()
        
        
        //initializes our hero and sets his initial texture to running1
        hero = SKSpriteNode(texture: heroAtlas.textureNamed("10Xmini_wizard"))
        hero.xScale = 0.5
        hero.yScale = 0.5
        hero.position = CGPointMake(frame.width / 4.0, frame.height / 4.0)
        
        //creates some CG values for the hero to be used in its physics definitions
        let heroSize = CGSizeMake(hero.size.width, hero.size.height)
        let heroCenter = CGPointMake(hero.position.x/2, hero.position.y/2)
        
        hero.physicsBody = SKPhysicsBody(rectangleOfSize: heroSize, center: heroCenter)
        hero.physicsBody?.dynamic = true
        hero.physicsBody?.mass = 4
        hero.physicsBody?.restitution = 0
        
        //init Mana Color
        mana = 0
        maxMana = 100
        manaPercent = (mana/maxMana)*100
        manaRegen = (10)
        
        manaWidth = manaPercent
        manaSize = CGSize(width: manaWidth, height: 30)
        manaBar = SKSpriteNode(color: UIColor(red: 20/255, green: 20/255, blue: 255/255, alpha: 1.0), size: manaSize)
        self.addChild(manaBar)
        
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
                                heroAtlas.textureNamed("10Xmini_wizard_jumping1"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2"),
                                heroAtlas.textureNamed("10Xmini_wizard_jumping2")
                                ], timePerFrame: 0.06)
                            
                            let jump = SKAction.repeatAction(jumping, count: 1)
                            
                            
                            if (hero.actionForKey("jumping") == nil)
                            {
                                hero.runAction(jump, withKey: "jumping")
                                hero.physicsBody?.velocity = CGVectorMake(0, 0)
                                hero.physicsBody?.applyImpulse(CGVectorMake(0, 3300))
                            }
                            
                        }
                            //I have no idea why this doesn't work so I commented
                            //out the code that adds the button
                            // IT WORKS, #BrennanFixesAllOfSeansPoorCode
                        else if spriteNode.name == "fire" {
                                fireBall()
                            
                        }
                    }
                }
            }
        }
    }
    
    func fireBall(){
        if mana >= 40 {
            let sprite = Fireball.createFireBall(point)
            self.addChild(sprite)
            mana = mana - 40
        }
    }
    
    func spawnEnemy(){
        let endOfScreen:CGPoint = CGPointMake(frame.width, frame.height/3.5)
        let sprite = Enemy.createEnemy(endOfScreen)
        self.addChild(sprite)
    }
    
    func addJumpButton(){
        var jump: SKSpriteNode!
        jump = SKSpriteNode(texture: heroAtlas.textureNamed("jump_button"))
        jump.position = CGPointMake(frame.width / 1.1, frame.height / 3.75)
        jump.name = "jump"
        jump.xScale = 0.3
        jump.yScale = 0.3
        self.addChild(jump)
    }
    
    func addFireButton(){
        var fire: SKSpriteNode!
        fire = SKSpriteNode(texture: heroAtlas.textureNamed("fire_button"))
        fire.name = "fire"
        fire.position = CGPointMake(frame.width / 10.0, frame.height / 3.75)
        fire.xScale = 0.3
        fire.yScale = 0.3
        self.addChild(fire)
    }
    
    func addManaOverlay(){
        manaOver = SKSpriteNode(texture: heroAtlas.textureNamed("mana_bar"))
        manaOver.position = CGPointMake(frame.width / 8.4, frame.height / 1.24)
        manaOver.physicsBody?.dynamic = false;
        self.addChild(manaOver)
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
            sprite.physicsBody?.restitution = 0
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
        
        //calls update manabar
        updateManaBar()
        
        //updates the CGpoint of hero's coordinates
        point = CGPointMake(hero.position.x + 50, hero.position.y + 10)
        
        //adds a frame before every frame to keep track of time
        frames = frames + 1
        
        //calculates time in seconds
        calculateTime()

    }
    
    //updates mana bar itself
    func updateManaBar(){
        calculateMana()
        manaWidth = manaPercent
        manaSize = CGSize(width: manaWidth * 1.2, height: 25)
        manaBar.size = manaSize
        manaBar.position = CGPointMake(frame.width / 8.4, frame.height / 1.24)
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
    
    //function to calculate time in seconds
    func calculateTime(){
        
        //if frames = 30 or higher (30 FPS) adds 1 to seconds
        if frames >= 30{
            frames = frames - 30
            time = time + 1
            spawnEnemy()
        }
    }
    
}

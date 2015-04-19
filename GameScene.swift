import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate
{
    var TheGame: SKNode!
    
    let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
    var ScoreBoard: UITextField!
    
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
    
    //Variables for fireball
    var fireBallPoint: CGPoint!
    var point: CGPoint!
    
    
    //Time Variables
    var time: Int!
    var frames: Int!
    var timePassed: Int!
    
    
    //Score Variables
    var Score: Int!
    var HighScore: Int!
    var PastScore: Int!
    
    //Stores the values for collisions
    enum ColliderType:UInt32 {
        case hero = 1
        case enemy = 2
        case fireball = 4
        case ground = 8
    }
    
    override func didMoveToView(view: SKView)
    {
        //sets physics collision delegator to this class
        self.physicsWorld.contactDelegate = self
        //shows physics boundaries
        //view.showsPhysics = true
        
        frames = 1
        time = 0
        timePassed = 0
        Score = 0
        
        // setup physics/gravity
        self.physicsWorld.gravity = CGVectorMake(0.0, -10)
        
        TheGame = SKNode()
        self.addChild(TheGame)
        
        createSky()
        createGround()
        addFireButton()
        addJumpButton()
        addManaOverlay()
        addHero()
        addManaBar()
        runForward()
        
        ScoreBoard = UITextField(frame: CGRect(x: 520, y: 26, width: 300, height: 20))
        ScoreBoard.backgroundColor = UIColor(red: 70/255, green: 120/255, blue: 180/255, alpha: 1.0)
        ScoreBoard.text = "Score: 0"
        ScoreBoard.textColor = UIColor.blackColor()
        view.addSubview(ScoreBoard)
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
                                hero.physicsBody?.applyImpulse(CGVectorMake(0, 3750))
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
    
    //this gets called automatically when 2 objects hit each other
    func didBeginContact(contact: SKPhysicsContact)
    {
        //variable stores the two things contacting
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask){
            
        case ColliderType.hero.rawValue | ColliderType.enemy.rawValue:
        println("U DEAD")
        
        // Configure the view.
        let scene = MainMenu()
        let skView = self.view as SKView!
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
            
        case ColliderType.fireball.rawValue | ColliderType.enemy.rawValue:
        contact.bodyA.node?.removeFromParent()
        contact.bodyB.node?.removeFromParent()
        println("BAT U DEAD")
        
        default:
        return
            
            
            
        }
    }
    
    //this gets called automatically when 2 objects stop hitting each other
    func didEndContact(contact: SKPhysicsContact)
    {
        
    }
    func addHero(){
        //initializes our hero and sets his initial texture to running1
        hero = SKSpriteNode(texture: heroAtlas.textureNamed("10Xmini_wizard"))
        hero.xScale = 0.4
        hero.yScale = 0.4
        hero.position = CGPointMake(frame.width / 4.0, frame.height / 4.0)
        
        //creates some CG values for the hero to be used in its physics definitions
        let heroSize = CGSizeMake(hero.size.width, hero.size.height)
        let heroCenter = CGPointMake(hero.position.x/2, hero.position.y/2)
        
        hero.physicsBody = SKPhysicsBody(circleOfRadius: hero.size.width/2.5)
        hero.physicsBody?.dynamic = true
        hero.physicsBody?.mass = 4
        hero.physicsBody?.restitution = 0
        hero.physicsBody?.allowsRotation = false
        
        //Physics Collision stuff
        //Tells the listener we care about this entity/stores its value
        hero.physicsBody!.categoryBitMask = ColliderType.hero.rawValue
        
        //what this can collide with
        hero.physicsBody!.contactTestBitMask = ColliderType.enemy.rawValue
        
        //Implements the listener
        hero.physicsBody!.collisionBitMask = ColliderType.enemy.rawValue
        self.addChild(hero);
        
    }
    
    func addManaBar(){
        //init Mana Color
        mana = 0
        maxMana = 100
        manaPercent = (mana/maxMana)*100
        manaRegen = (10)
        
        manaWidth = manaPercent
        manaSize = CGSize(width: manaWidth, height: 30)
        manaBar = SKSpriteNode(color: UIColor(red: 20/255, green: 20/255, blue: 255/255, alpha: 1.0), size: manaSize)
        self.addChild(manaBar)
    }

    
    func fireBall(){
        if mana >= 40 {
            let firing = SKAction.animateWithTextures([
                heroAtlas.textureNamed("10Xmini_wizard_firing"),
                heroAtlas.textureNamed("10Xmini_wizard_firing"),
                heroAtlas.textureNamed("10Xmini_wizard_firing"),
                heroAtlas.textureNamed("10Xmini_wizard_firing")
                ], timePerFrame: 0.08)
            
             let fire = SKAction.repeatAction(firing, count: 1)
            
            if (hero.actionForKey("firing") == nil)
            {
                hero.runAction(fire, withKey: "jumping")
            }
            
            //creates the Fireball itself
            let sprite = Fireball.createFireBall(point)
            
            //registers the fireball as something to pay attention to
            sprite.physicsBody!.categoryBitMask = ColliderType.fireball.rawValue
            
            //tells the object what things it can bounce off of and so forth
            sprite.physicsBody!.contactTestBitMask = ColliderType.fireball.rawValue
            
            //tells the object the we care when it hits this thing
            sprite.physicsBody!.collisionBitMask = ColliderType.fireball.rawValue
            self.addChild(sprite)
            mana = mana - 40
        }
    }
    
    func spawnEnemy(){
        //println(frame.height)
        let endOfScreen:CGPoint = CGPointMake(frame.width, frame.height/1.75)
        let sprite = Enemy.createEnemy(endOfScreen)
        
        sprite.physicsBody!.categoryBitMask = ColliderType.enemy.rawValue
        sprite.physicsBody!.contactTestBitMask = ColliderType.hero.rawValue | ColliderType.fireball.rawValue
        sprite.physicsBody!.collisionBitMask = ColliderType.hero.rawValue | ColliderType.fireball.rawValue
        
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
        
        //updates ScoreBoard
        ScoreBoard.text = "Score: \(Score)"
        
        //calculates time in seconds
        calculateTime()
        calculateScore()
        
        calcEnemy()
        
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
        }
    }
    
    func calcEnemy(){
        var randomnumber:UInt32 = UInt32(pow(1.01, Double(-(time-200))))
            
        var randomnumbers:UInt32 = randomnumber + 100
        //println("random = \(randomnumbers)")
        
        var random = arc4random_uniform(randomnumbers)
        
        if(random == 1){
            spawnEnemy()
        }
        
    }
    
    func calculateScore(){
        
        Score = Score + 1 + time
        println(Score)
        
    }
    
    
    
}

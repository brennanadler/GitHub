import Foundation
import SpriteKit

class Bat: SKSpriteNode {
    
    
    class func createEnemy(location: CGPoint) -> Bat {
        let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
        
        let sprite = Bat(texture: heroAtlas.textureNamed("10XBat1"))
        sprite.position = location
        let spriteSize = CGSizeMake(sprite.size.width, sprite.size.height)
        let spriteCenter = CGPointMake(sprite.position.x/2, sprite.position.y/2)
        
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width/3)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            
            physics.velocity = CGVectorMake(-300, 0)
            physics.mass = 0
            physics.restitution = 0
            physics.friction = 0
            //Basically wind resistance, the default value was .1
            physics.linearDamping = 0
            //physics.usesPreciseCollisionDetection = false
            //physics.collisionBitMask = 0
        }
        
        let bat_anim = SKAction.animateWithTextures([
            heroAtlas.textureNamed("10XBat1"),
            heroAtlas.textureNamed("10XBat2")
            ], timePerFrame: 0.12)
        
        let run = SKAction.repeatActionForever(bat_anim)
        
        sprite.runAction(run, withKey: "bat")
        
        sprite.xScale = 0.4
        sprite.yScale = 0.4
        
        return sprite
    }
}

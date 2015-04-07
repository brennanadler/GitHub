import Foundation
import SpriteKit

class Fireball: SKSpriteNode {
    
    
    class func createFireBall(location: CGPoint) -> Fireball {
        let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
        
        let sprite = Fireball(texture: heroAtlas.textureNamed("fireball1"))
        sprite.position = location
        let spriteSize = CGSizeMake(sprite.size.width, sprite.size.height)
        let spriteCenter = CGPointMake(sprite.position.x/2, sprite.position.y/2)
        
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.velocity = CGVectorMake(600, 0)
        }
        
        let fireball_anim = SKAction.animateWithTextures([
            heroAtlas.textureNamed("fireball1"),
            heroAtlas.textureNamed("fireball2")
            ], timePerFrame: 0.12)
        
        let run = SKAction.repeatActionForever(fireball_anim)
        
        sprite.runAction(run, withKey: "fire")
        
        sprite.xScale = 3.0
        sprite.yScale = 3.0
        
        return sprite
    }
}

import Foundation
import SpriteKit

class Fireball: SKSpriteNode {
    
    
    class func createFireBall(location: CGPoint) -> Fireball {
        let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
        
        let sprite = Fireball(texture: heroAtlas.textureNamed("fireball1"))
        sprite.position = location
        let spriteSize = CGSizeMake(sprite.size.width, sprite.size.height)
        let spriteCenter = CGPointMake(sprite.position.x/2, sprite.position.y/2)
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSize, center: spriteCenter)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.velocity = CGVectorMake(600, 0)
        }
        
        let fireball_anim = SKAction.animateWithTextures([
            heroAtlas.textureNamed("fireball1"),
            heroAtlas.textureNamed("fireball2")
            ], timePerFrame: 0.06)
        
        let run = SKAction.repeatActionForever(fireball_anim)
        
        sprite.runAction(run, withKey: "fire")
        
        sprite.xScale = 2.0
        sprite.yScale = 2.0
        
        return sprite
    }
}

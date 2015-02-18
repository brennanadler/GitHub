import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    
    
    class func createEnemy(location: CGPoint) -> Enemy {
        let heroAtlas = SKTextureAtlas(named: "wizard.atlas")
        
        let sprite = Enemy(texture: heroAtlas.textureNamed("fireball1"))
        sprite.position = location
        let spriteSize = CGSizeMake(sprite.size.width, sprite.size.height)
        let spriteCenter = CGPointMake(sprite.position.x/2, sprite.position.y/2)
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSize, center: spriteCenter)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.velocity = CGVectorMake(-300, 0)
        }
        
        sprite.xScale = 5.0
        sprite.yScale = 5.0
        
        return sprite
    }
}

import Foundation
import SpriteKit

class Fireball: SKSpriteNode {
    
    class func createFireBall(location: CGPoint) -> Fireball {
        
        let sprite = Fireball(imageNamed: "fireball")
        sprite.position = location
        let spriteSize = CGSizeMake(sprite.size.width, sprite.size.height)
        let spriteCenter = CGPointMake(sprite.position.x/2, sprite.position.y/2)
        
        sprite.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSize, center: spriteCenter)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.velocity = CGVectorMake(500, 0)
        }
        
        sprite.xScale = 2.0
        sprite.yScale = 2.0
        
        return sprite
    }
}

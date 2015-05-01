import UIKit
import SpriteKit
import iAd


class GameViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //finds dimensions of screen (ipad vs iphone etc.)
        var bounds: CGRect = UIScreen.mainScreen().bounds
        var width:CGFloat = bounds.size.width
        var height:CGFloat = bounds.size.height
        
        //Makes a global variable to store the Scale variables (Default is iPhone6)
        NSUserDefaults.standardUserDefaults().setFloat(Float(width / 667), forKey: "xScale")
        NSUserDefaults.standardUserDefaults().setFloat(Float(height / 375), forKey: "yScale")
        println("width: \(width), height: \(height)")
        println("xScaler, yScaler \(width/667) ,\(height/375)")
        
        //creates permanent Integer named "HighScore" that is an integer... Default value 0
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "HighScore")
        NSUserDefaults.standardUserDefaults().setInteger(50, forKey: "Coins")
        
        
        //Notification that will run the func hideBannerAd() and has name of hideadsID
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideBannerAd", name: "hideadsID", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showBannerAd", name: "showadsID", object: nil)
        
        let scene = MainMenu()
        // Configure the view.
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        scene.size = skView.bounds.size
        
        skView.presentScene(scene)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

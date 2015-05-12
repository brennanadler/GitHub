








import UIKit
import SpriteKit
import iAd


class GameViewController: UIViewController,ADInterstitialAdDelegate {
    
    var interstitial:ADInterstitialAd!
    var placeHolderView:UIView!
    var closeButton:UIButton!
    var skView:SKView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //finds dimensions of screen (ipad vs iphone etc.)
        var bounds: CGRect = UIScreen.mainScreen().bounds
        var width:CGFloat = bounds.size.width
        var height:CGFloat = bounds.size.height
        
        //Makes a global variable to store the Scale variables (Default is iPhone6)
        NSUserDefaults.standardUserDefaults().setFloat(Float(width / 667), forKey: "xScale")
        NSUserDefaults.standardUserDefaults().setFloat(Float(height / 375), forKey: "yScale")
        
        //creates permanent Integer named "HighScore" that is an integer... Default value 0
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "HighScore")
        NSUserDefaults.standardUserDefaults().setInteger(50, forKey: "Gems")
        
        //Skin Value
        NSUserDefaults.standardUserDefaults().setObject("_1", forKey: "SkinSuffix")
        
        //Notification that will run the func runAdd() and has name of runadsID
        NSNotificationCenter.defaultCenter().addObserver(self, selector: ("runAd:"),    name: "runadsID", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: ("loadAd:"),    name: "loadadsID", object: nil)

        
        let scene = MainMenu()
        // Configure the view.
        skView = self.view as SKView
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
    
    //deletes previous ad and creates a new one, triggers at start of game to give it time to load
    func loadAd(notification:NSNotification){
        cycleInterstitial()
    }
    
    //iAD interstitial
    func runAd(notification:NSNotification){
        //var timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("dislayiAdInterstitial"), userInfo: nil, repeats: false)
        dislayiAdInterstitial()
    }
    
    func cycleInterstitial(){
        
        // Clean up the old interstitial...
        //  interstitial.delegate = nil;
        // and create a new interstitial. We set the delegate so that we can be notified of when
        interstitial = ADInterstitialAd()
        interstitial.delegate = self;

    }
    
    func presentInterlude(){
        // If the interstitial managed to load, then we'll present it now.
        println("is ad loaded?")
        if (interstitial.loaded) {
            placeHolderView = UIView(frame: self.view.frame)
            self.view.addSubview(placeHolderView)
            
            interstitial.presentInView(placeHolderView)
            
            var timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("addCloser"), userInfo: nil, repeats: false)
            
        }
    }
    
    func addCloser(){
        closeButton = UIButton(frame: CGRect(x: skView.bounds.width / 30
            , y:  skView.bounds.height / 20, width: 25, height: 25))
        closeButton.setBackgroundImage(UIImage(named: "Exit"), forState: UIControlState.Normal)
        closeButton.addTarget(self, action: Selector("close"), forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(closeButton)
    }
    // iAd Delegate Mehtods
    
    // When this method is invoked, the application should remove the view from the screen and tear it down.
    // The content will be unloaded shortly after this method is called and no new content will be loaded in that view.
    // This may occur either when the user dismisses the interstitial view via the dismiss button or
    // if the content in the view has expired.
    
    func interstitialAdDidUnload(interstitialAd: ADInterstitialAd!){
        self.placeHolderView.removeFromSuperview()
        
        closeButton.removeFromSuperview()
        interstitial = nil
        
        cycleInterstitial()
    }
    
    
    func interstitialAdActionDidFinish(_interstitialAd: ADInterstitialAd!){
        placeHolderView.removeFromSuperview()
        closeButton.removeFromSuperview()
        interstitial = nil
        
        println("called just before dismissing - action finished")
        
    }
    
    // This method will be invoked when an error has occurred attempting to get advertisement content.
    // The ADError enum lists the possible error codes.
    func interstitialAd(interstitialAd: ADInterstitialAd!,
        didFailWithError error: NSError!){
            cycleInterstitial()
    }
    
    
    //Load iAd interstitial
    func dislayiAdInterstitial() {
        //iAd interstitial
        presentInterlude()
    }
    
    
    func close() {
        placeHolderView.removeFromSuperview()
        closeButton.removeFromSuperview()
        interstitial = nil
        
    }
    
}

//
//  PlayerSegue.swift
//  Capstone 01
//
//  Created by Rick Bowen on 10/18/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import Foundation
//@objc(UncoverVerticalSegue) // Your app will crash if you don't add this line, remember: Swift is still in Beta.


class PlayerSegue: UIStoryboardSegue
{
    
    override func perform()
    { // We override the function in UIStoryboardSegue to do what we want.
        
        var sourceViewController = self.sourceViewController as UIViewController // This is the view controller where you are.
        var destinationViewController = self.destinationViewController as UIViewController // This is the view controller where you want to be.
        var duplicatedSourceView: UIView = sourceViewController.view.snapshotViewAfterScreenUpdates(false) // Create a screenshot of the old view.
        
        /* We add a screenshot of the old view (Bottom) above the new one (Top), it looks like nothing changed. */
        destinationViewController.view.addSubview(duplicatedSourceView)
        
        sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil) // source -> destination, no animations.
        
        /* Our main view is now destinationViewController.
        sourceViewController.presentViewController(destinationViewController, animated: false, completion: {
            UIView.animateWithDuration(0.33, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut,
                animations: { () -> Void in
                    /*
                    This is the block affected by the animation. Duration: 0,33s. Options: Ease-Out speed curve.
                    We slide the old view's screenshot at the bottom of the screen.
                    */
                    duplicatedSourceView.transform = CGAffineTransformMakeTranslation(0, -50)
                },
                completion: { (finished: Bool) -> Void in
                    /* The animation is finished, we removed the old view's screenshot. */
                    //duplicatedSourceView.removeFromSuperview()
            })
        })*/
    }
    
}
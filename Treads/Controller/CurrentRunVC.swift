//
//  CurrentRunVC.swift
//  Treads
//
//  Created by James Volmert on 7/25/19.
//  Copyright © 2019 James Volmert. All rights reserved.
//

import UIKit

class CurrentRunVC: LocationVC {

    @IBOutlet weak var swipeBackgroundImage: UIImageView!
    @IBOutlet weak var buttonSwipe: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender: )))
        buttonSwipe.addGestureRecognizer(swipeGesture)
        buttonSwipe.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func endRunSwiped(sender: UIPanGestureRecognizer) {
        let minAdjust: CGFloat = 80
        let maxAdjust: CGFloat = 128
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBackgroundImage.center.x - minAdjust) && sliderView.center.x <= (swipeBackgroundImage.center.x + maxAdjust) {
                    sliderView.center.x = sliderView.center.x + translation.x
                } else if sliderView.center.x >= (swipeBackgroundImage.center.x + maxAdjust) {
                    sliderView.center.x = swipeBackgroundImage.center.x + maxAdjust
                    
                    dismiss(animated: true, completion: nil)
                } else {
                    sliderView.center.x = swipeBackgroundImage.center.x - minAdjust
                }
                
                sender.setTranslation(CGPoint.zero, in: self.view)
            } else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1, animations: {
                    sliderView.center.x = self.swipeBackgroundImage.center.x - minAdjust
                })
            }
        }
    }


}

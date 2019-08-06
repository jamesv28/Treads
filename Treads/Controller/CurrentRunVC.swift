//
//  CurrentRunVC.swift
//  Treads
//
//  Created by James Volmert on 7/25/19.
//  Copyright © 2019 James Volmert. All rights reserved.
//

import UIKit
import MapKit

class CurrentRunVC: LocationVC {

    @IBOutlet weak var swipeBackgroundImage: UIImageView!
    @IBOutlet weak var buttonSwipe: UIImageView!
    @IBOutlet weak var duationLabel: UILabel!
    @IBOutlet weak var pacleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pauseBtn: UIButton!
    
    var startLocation : CLLocation!
    var lastLocation : CLLocation!
    var runDistance : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender: )))
        buttonSwipe.addGestureRecognizer(swipeGesture)
        buttonSwipe.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
    }
    
    func startRun() {
        manager?.startUpdatingLocation()
    }

    @IBAction func pauseBtnPressed(_ sender: Any) {
        
    }
    
    func endRun() {
        manager?.stopUpdatingLocation()
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

extension CurrentRunVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
            
        }
        else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
            distanceLabel.text = "\(runDistance.metersToMiles(places: 2))"
            
        }
        lastLocation = locations.last
    }
}



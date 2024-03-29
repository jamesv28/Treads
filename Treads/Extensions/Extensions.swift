//
//  Extensions.swift
//  Treads
//
//  Created by James Volmert on 8/6/19.
//  Copyright © 2019 James Volmert. All rights reserved.
//

import Foundation


extension Double {
    
    func metersToMiles(places : Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return ((self / 1609.34 ) * divisor).rounded() / divisor
    }
}

extension Int {
    
    func formattimeDurationToString() -> String {
        let durationHours = self / 3600
        let durationMinutes = (self % 3600) / 60
        let durationSeconds = (self % 3600) % 60
        
        if durationSeconds < 0 {
            return "00:00:00"
        } else {
            if durationHours == 0 {
                return String(format: "%02d:%02d", durationMinutes, durationSeconds)
            } else {
                return String(format: "%02d:%02d:%02d", durationHours, durationMinutes, durationSeconds)
            }
        }
    }
}

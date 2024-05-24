//
//  ActivityCalculator.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/23/24.
//

import Foundation

class ActivityCalculator {
    let samples: [ActivityEntity]
    
    init (_ samples: [ActivityEntity]) {
        self.samples = samples
    }
    
    func calculateSum() -> Double {
        return samples.reduce(0) { $0 + $1.quantity }
    }
}

//
//  ActivityCore.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/23/24.
//

import Foundation

// 사실상 무의미
class ActivityCore {
    let samples: [ActivityEntity]
    
    init (_ samples: [ActivityEntity]) {
        self.samples = samples
    }
    
    func calculateSum() -> Double {
        return ActivityCalculator(samples).calculateSum()
    }
}

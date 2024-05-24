//
//  HeartRateCalculator.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

class HeartRateCalculator {
    let samples: [HeartRateEntity]
    
    init(_ samples: [HeartRateEntity]) {
        self.samples = samples
    }
    
    func calculateAverage() -> Double {
        guard !samples.isEmpty else { return 0.0 }
        let totalQuantity = samples.reduce(0) { $0 + $1.quantity }
        return totalQuantity / Double(samples.count)
    }
    
}

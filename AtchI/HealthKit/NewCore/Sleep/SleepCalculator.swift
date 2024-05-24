//
//  SampleCalculator.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

class SleepCalculator {
    let samples: [SleepEntity]
    
    init (_ samples: [SleepEntity]) {
        self.samples = samples
    }
    
    func calculateSum() -> Int {
        let calendar = Calendar.current
        let sum = samples
            .reduce(into: 0) { (result, sample) in
                let minutes = calendar
                    .dateComponents(
                        [.minute],
                        from: sample.startDate,
                        to: sample.endDate)
                    .minute ?? 0
                result += minutes
            }
        return sum
    }
}


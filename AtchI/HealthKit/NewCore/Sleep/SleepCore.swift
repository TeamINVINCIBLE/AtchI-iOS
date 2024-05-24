//
//  SleepCore.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

class SleepCore {
    func calculateSleepTimeQuentity(
        _ samples: [SleepEntity],
        sleepType: HKSleepType = .inbed
    ) -> Int? {
        let sleepSamples = AlternativeSampleFilter(
            preConditions: [IsWatchCondition(), SleepTypeCondition(sleepType)],
            alternativeConditions: [SleepTypeCondition(.inbed)]
        ).filter(samples)
            .map { $0 as! SleepEntity }
        
        return SleepCalculator(sleepSamples).calculateSum()
    }
    
    func calculateSleepStartDate(_ samples: [SleepEntity]) -> Date {
        return IndexSampleFilter(0).filter(samples).startDate
    }
    
    func calculateSleepEndDate(_ samples: [SleepEntity]) -> Date {
        let lastIndex = samples.count - 1
        return IndexSampleFilter(lastIndex).filter(samples).endDate
    }
//
//    func getSleepInterval(input samples: [HKSleepEntity]) throws -> [HKSleepIntervalModel] {
//        <#code#>
//    }
}

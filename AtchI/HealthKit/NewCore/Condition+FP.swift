//
//  Condition+FP.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/24/24.
//

import Foundation

enum SampleCondition: Condition {
    case isWatch
    case isPhone
    case notContain(_ samples: [SampleEntity])
    case sameMinute(baseDate: Date)
    
    func isSatisfy(_ sample: SampleEntity) -> Bool {
        switch self {
        case .isWatch:
            return sample.dateSourceProductType == .watch
        case .isPhone:
            return sample.dateSourceProductType == .iPhone
        case let .notContain(samples):
            return !samples.contains(sample)
        case let .sameMinute(baseDate):
            let calendar = Calendar.current
            let baseDateComponents = calendar.dateComponents([.day, .hour, .minute], from: baseDate)
            let targetDateComponents = calendar.dateComponents([.day, .hour, .minute], from: sample.startDate)

            return targetDateComponents == baseDateComponents
        }
    }
}

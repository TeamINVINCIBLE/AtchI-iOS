//
//  NewNewSleepCore.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/24/24.
//

import Foundation

class NewNewSleepCore {
    func calculateSleepTimeQuentity(
        sleepType: HKSleepType,
        samples: [HKSleepEntity]
    ) -> Int? {
        
        let watchSamples = samples
            .filter{ isFromWatch($0) }
        
        var claculatedSampels: [HKSleepEntity] = {
            if watchSamples.isEmpty {
                if sleepType != .inbed { // inbed 외에는 워치 데이터 필수
                    return []
                }
                return samples
            } else {
                return watchSamples
            }
        }()
        
        let calendar = Calendar.current
        let sum = claculatedSampels
            .filter{ $0.sleepType == sleepType }
            .reduce(into: 0) { (result, sample) in
                let minutes = calendar
                    .dateComponents(
                    [.minute],
                    from: sample.startDate,
                    to: sample.endDate)
                    .minute ?? 0
                result += minutes
            }
        
        // 데이터가 없으면 nil 반환 (애플워치 데이터가 없는 경우 등)
        return sum == 0 ? nil : sum
    }
    
    private func isFromWatch(_ sample: HKSleepEntity) -> Bool {
        return sample.dateSourceProductType == .watch
    }

    
    func calculateSleepStartDate(
        samples: [HKSleepEntity]
    ) -> Date {
        if let stratDate = samples.first?.startDate {
            return stratDate
        } else {
            fatalError("올바른 수면 데이터가 아닙니다")
        }
    }
    
    
    func calculateSleepEndDate(
        samples: [HKSleepEntity]
    ) -> Date {
        if let endDate = samples.last?.endDate {
            return endDate
        } else {
            fatalError("올바른 수면 데이터가 아닙니다")
        }
    }
}

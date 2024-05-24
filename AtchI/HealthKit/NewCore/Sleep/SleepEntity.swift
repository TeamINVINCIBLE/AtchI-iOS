//
//  SleepEntity.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

class SleepEntity: SampleEntity {
    let sleepType: HKSleepType
    
    init(startDate: Date, endDate: Date, dateSourceProductType: HKProductType, sleepType: HKSleepType) {
        self.sleepType = sleepType
        super.init(startDate: startDate, endDate: endDate, dateSourceProductType: dateSourceProductType)
    }
}

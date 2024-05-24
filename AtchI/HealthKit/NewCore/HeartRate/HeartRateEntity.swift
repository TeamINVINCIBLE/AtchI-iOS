//
//  HeartRateEntity.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

class HeartRateEntity: SampleEntity {
    let quantity: Double
    
    init(startDate: Date, endDate: Date, dateSourceProductType: HKProductType, quantity: Double) {
        self.quantity = quantity
        super.init(startDate: startDate, endDate: endDate, dateSourceProductType: dateSourceProductType)
    }
}

//
//  SleepFilter.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

protocol Filter {
    func filter(_ samples: [SampleEntity]) -> [SampleEntity]
}

protocol SingleFilter {
    func filter(_ samples: [SampleEntity]) -> SampleEntity
}

protocol GroupingFilter {
    func filter(_ samples: [SampleEntity]) -> [[SampleEntity]]
}


class SampleFilter: Filter {
    private let conditions: [Condition]
    
    init(conditions: [Condition]) {
        self.conditions = conditions
    }
    
    func filter(_ samples: [SampleEntity]) -> [SampleEntity] {
        return samples.filter { sample in
            conditions.allSatisfy({
                $0.isSatisfy(sample)
            })
        }
    }
}

class AlternativeSampleFilter: Filter {
    private let preConditions: [Condition]
    private let alternativeConditions: [Condition]
    
    init(preConditions: [Condition], alternativeConditions: [Condition]) {
        self.preConditions = preConditions
        self.alternativeConditions = alternativeConditions
    }
    
    func filter(_ samples: [SampleEntity]) -> [SampleEntity] {
        let preConditionSatisfy = samples.filter { sample in
            preConditions.allSatisfy { condition in
                condition.isSatisfy(sample)
            }
        }
        if preConditionSatisfy.isEmpty {
            return samples.filter { sample in
                alternativeConditions.allSatisfy { condition in
                    condition.isSatisfy(sample)
                }
            }
        } else {
            return preConditionSatisfy
        }
    }
}

class IndexSampleFilter: SingleFilter {
    private let index: Int
    
    init(_ index: Int) {
        self.index = index
    }
    
    func filter(_ samples: [SampleEntity]) -> SampleEntity {
        guard index >= 0 && index < samples.count else {
            fatalError("올바른 데이터가 아닙니다")
        }
        let sortedSamples = samples.sorted { $0.startDate < $1.startDate }
        return sortedSamples[index]
    }
}

class TimeGroupingFilter: GroupingFilter {
    private let timeComponent: [Calendar.Component]
    
    init(_ timeComponent: [Calendar.Component]) {
        self.timeComponent = timeComponent
    }
    
    func filter(_ samples: [SampleEntity]) -> [[SampleEntity]] {
        return samples
            .sorted { $0.startDate < $1.startDate }
            .reduce(into: [[HeartRateEntity]]()) { (result, sample) in
                guard let lastGroup = result.last else {
                    result.append([sample])
                    return
                }

                let filtered = SampleFilter(
                    conditions: [
                        NotContainCondition(lastGroup),
                        SameTimeCondition(sample.startDate, components: timeComponent)
                    ]
                ).filter(samples)
                
                result.append(filtered)
            }
    }

}

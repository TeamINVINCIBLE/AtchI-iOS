//
//  SleepFilter.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

extension Array where Element: SampleEntity {
    func filter(with conditions: [SampleCondition]) -> [Element] {
        return self.filter { sample in
            conditions.allSatisfy { condition in
                condition.isSatisfy(sample)
            }
        }
    }
}



extension Array where Element: SampleEntity {
    func filter(with preConditions: [Condition], alternativeConditions: [Condition]) -> [Element] {
        let preConditionSatisfy = self.filter { sample in
            preConditions.allSatisfy { condition in
                condition.isSatisfy(sample)
            }
        }
        if preConditionSatisfy.isEmpty {
            return self.filter { sample in
                alternativeConditions.allSatisfy { condition in
                    condition.isSatisfy(sample)
                }
            }
        } else {
            return preConditionSatisfy
        }
    }
}

//protocol Filter {
//    func filter(_ samples: [SampleEntity]) -> [SampleEntity]
//}
//
//protocol SingleFilter {
//    func filter(_ samples: [SampleEntity]) -> SampleEntity
//}

class SampleFilter {
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

class AlternativeSampleFilter {
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

class IndexSampleFilter {
    private let index: Int
    
    init(_ index: Int) {
        self.index = index
    }
    
    func filter(_ samples: [SampleEntity]) -> SampleEntity {
        guard index >= 0 && index < samples.count else {
            fatalError("올바른 수면 데이터가 아닙니다")
        }
        let sortedSamples = samples.sorted { $0.startDate < $1.startDate }
        return sortedSamples[index]
    }
}

class GroupingFilter {
    private let samples: [SampleEntity]
    private let conditions: [Condition]
    
    init(samples: [SampleEntity], conditions: [Condition]) {
        self.samples = samples
        self.conditions = conditions
    }
    
    func filter(_ samples: [SampleEntity]) -> [[SampleEntity]] {
        return samples
            .sorted { $0.startDate < $1.startDate }
            .reduce(into: [[SampleEntity]]()) { (result, sample) in
                guard let lastGroup = result.last else {
                    result.append([sample])
                    return
                }

                let filtered = SampleFilter(
                    conditions: [NotContainCondition(lastGroup)] + conditions
                ).filter(samples)
                
                result.append(filtered)
            }
    }
}

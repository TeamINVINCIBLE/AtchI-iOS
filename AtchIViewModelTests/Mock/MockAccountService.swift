//
//  AtchIViewModelTests.swift
//  AtchITests
//
//  Created by DOYEON LEE on 2023/04/06.
//

@testable import AtchI
import Foundation
import Combine // Cancellable 때문에 import
import Moya // Response 때문에 import

enum MockEmail: String {
    case duplicatedEmail = "duplicated@example.com"
}

class MockAccountService: AccountServiceType {
    func requestEmailConfirm(email: String) -> AnyPublisher<AtchI.EmailVerificationModel, AtchI.AccountError> {
        
        return Just(AtchI.EmailVerificationModel(message: "",
                                                 verificationCode: ""))
        .setFailureType(to: AccountError.self)
        .eraseToAnyPublisher()
    }
    
    
    var cancellables = Set<AnyCancellable>()
    
    func requestSignup(signupModel: SignupModel) -> AnyPublisher<Response, AccountError> {
        
        if signupModel.email == MockEmail.duplicatedEmail.rawValue {
            return Fail(error: AccountError.emailDuplicated)
            .eraseToAnyPublisher()
        }
        
        // 응답 생성
        let jsonDict: [String: Any] = ["mid": "-1"]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else {
            return Fail(error: AccountError.common(.jsonSerializationFailed))
            .eraseToAnyPublisher()}
        
        // SignupModel에 따른 유효한 Response 값을 생성하여 AnyPublisher로 반환
        let response = Response(statusCode: 200, data: jsonData)
        
        return Just(response)
            .setFailureType(to: AccountError.self)
            .eraseToAnyPublisher()
    }
}
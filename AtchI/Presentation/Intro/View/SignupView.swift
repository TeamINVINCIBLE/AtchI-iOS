//
//  SignupView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/16.
//

import SwiftUI
import Combine

struct SignupView: View {
    
    @ObservedObject var viewModel: SignupViewModel
    
    @State var sendedEmailCertification: Bool = false
    
    init() {
        self.viewModel = SignupViewModel(
            validationServcie: ValidationService(),
            accountService: AccountService())
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 20) {
                    Text("회원가입")
                        .font(.titleLarge)
                    
                    // Input list
                    Spacer(minLength: 15)
                    TextInput(title: "이름",
                              placeholder: "이름을 입력해주세요",
                              text: $viewModel.name,
                              errorMessage: $viewModel.nameErrorMessage)
                    VStack {
                        TextInput(title: "이메일",
                                  placeholder: "예) junjongsul@gmail.com",
                                  text: $viewModel.email,
                                  errorMessage: $viewModel.emailErrorMessage)
                        TextInput(title: "",
                                  placeholder: "이메일 인증번호를 입력해주세요",
                                  text: $viewModel.email,
                                  errorMessage: $viewModel.emailErrorMessage)
                        ThinLightButton(title: sendedEmailCertification ? "이메일 인증 다시 보내기" : "이메일 인증하기", onTap: viewModel.$tapEmailCertificationButton, disabled: $viewModel.disabledEmailCertificationField)
                    }
                    ToogleInput(title:"성별",
                                options: ["남", "여"])
                    TextInput(title: "생년월일",
                              placeholder: "8자리 생년월일 ex.230312",
                              text: $viewModel.birth,
                              errorMessage: $viewModel.birthErrorMessage)
                    SecureInput(title: "비밀번호",
                                placeholder: "비밀번호를 입력해주세요",
                                secureText: $viewModel.password,
                                errorMessage: $viewModel.passwordErrorMessage)
                    SecureInput(title: "비밀번호 확인",
                                placeholder: "비밀번호를 한번 더 입력해주세요",
                                secureText: $viewModel.passwordAgain,
                                errorMessage: $viewModel.passwordAgainErrorMessage)
                }
                
                // Complete Button
                Spacer(minLength: 20)
                DefaultButton(
                       buttonSize: .large,
                       buttonStyle: .filled,
                       buttonColor: .mainPurple,
                       isIndicate: false,
                       action: {
                           print("회원가입하기 click")
                       },
                       content: {
                           Text("회원가입하기")
                       }
                   )
                Spacer(minLength: 20)
                
                // Already signup
                HStack (alignment: .center, spacing: 3) {
                    Text("이미 가입하셨나요? ")
                        .foregroundColor(.grayTextLight)
                    Text("로그인하기")
                        .foregroundColor(.grayTextLight)
                        .underline()
                        .onTapGesture {
                            // 로그인뷰로 이동이동
                        }
                }
                
                // Bottom margin
                Spacer(minLength: 30)
            }
            .padding(.horizontal, 30)
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    
    // This function hides the keyboard when called by sending the 'resignFirstResponder' action to the shared UIApplication.
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct SingupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}


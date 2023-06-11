//
//  AppTitleBar.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/13.
//

import SwiftUI

struct AppTitleBar: View {
    
    @State var isPresentModal = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack{
            Image("logo_gray")
                .imageScale(.large)
            Text("엣치")
                .font(.bodyLarge)
                .foregroundColor(.grayTextLight)
            Spacer()
            Image("question_circle")
                .foregroundColor(.grayDisabled)
                .padding(.trailing, 20)
                .onTapGesture {
                   isPresentModal = true
                }
                
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .sheet(isPresented: $isPresentModal) {
            ReadMeView(urlToLoad: "https://github.com/Team-cheonhamujeok/AtchI-iOS/blob/main/README.md")
        }
    }
}

//
//  AtchIApp.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/09.
//

import SwiftUI

import Network

@main
struct AtchIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var networkMonitor = NetworkMonitor()
 
    var body: some Scene {
        WindowGroup {
            if networkMonitor.isConnected {
                RootBuilder()
            } else {
                NetworkErrorView()
            }
        }
    }
}


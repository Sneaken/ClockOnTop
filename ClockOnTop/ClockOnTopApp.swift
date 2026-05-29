//
//  ClockOnTopApp.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private let windowController = FloatingWindowController()

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.setActivationPolicy(.accessory)
        windowController.setupWindow()
    }
}

@main
struct ClockOnTopApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        _EmptyScene()
    }
}

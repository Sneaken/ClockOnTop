//
//  ClockOnTopApp.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSPanel!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // 使应用不在状态栏中显示
        NSApplication.shared.setActivationPolicy(.accessory)

        // Set up the window.
        window = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [
                .borderless,
                .resizable,
                .utilityWindow,
                .fullSizeContentView,
                .nonactivatingPanel,
            ],
            backing: .buffered, defer: false)

        window.center()
        window.setFrameAutosaveName("Main Window")

        // 设置窗口浮动
        window.level = .mainMenu
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        // 隐藏按钮
        window.standardWindowButton(.closeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
        // 隐藏标题栏
        window.titlebarAppearsTransparent = true // This line hides the title bar
        window.titleVisibility = .hidden

        window.isRestorable = true

        // 能够移动
        window.isMovableByWindowBackground = true
        window.backgroundColor = NSColor(red: 0.9, green: 1.0, blue: 0.98, alpha: 0.7)
        // Fix: 透明底色下的文字阴影残留
        window.hasShadow = false
        var keyboardEventListener: Any?

        // Create the SwiftUI view that provides the window contents.
        let contentView = FullScreenTimeDisplay().environmentObject(UserSettings()).onHover { isHovering in
            if isHovering {
                self.window.alphaValue = 0.1
                self.window.ignoresMouseEvents = true
                // 监听 Command 事件
                keyboardEventListener = NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) { event in
                    if event.modifierFlags.contains(.command) {
                        self.window.ignoresMouseEvents = false
                        self.window.alphaValue = 1
                    }
                }
            } else {
                self.window.alphaValue = 1
                self.window.ignoresMouseEvents = false
                // Remove keyboard event listener here
                if let listener = keyboardEventListener {
                    NSEvent.removeMonitor(listener)
                }
            }
        }
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(self)
        window.orderFrontRegardless()
    }
}

@main
struct ClockOnTopApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        _EmptyScene()
    }
}

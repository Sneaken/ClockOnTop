//
//  FloatingWindowController.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI
import Combine

final class FloatingWindowController {
    private var window: NSPanel?
    private var keyboardMonitor: Any?
    private var cancellables = Set<AnyCancellable>()

    func setupWindow() {
        let panel = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.borderless, .resizable, .fullSizeContentView, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        panel.center()
        panel.setFrameAutosaveName("Main Window")
        panel.level = .mainMenu
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        panel.standardWindowButton(.closeButton)?.isHidden = true
        panel.standardWindowButton(.miniaturizeButton)?.isHidden = true
        panel.standardWindowButton(.zoomButton)?.isHidden = true
        panel.titlebarAppearsTransparent = true
        panel.titleVisibility = .hidden
        panel.isRestorable = true
        panel.isMovableByWindowBackground = true
        panel.backgroundColor = .clear
        panel.isOpaque = false
        panel.hasShadow = false

        let settings = UserSettings()
        let contentView = FullScreenTimeDisplay()
            .environmentObject(settings)
            .onHover { [weak self, weak panel] isHovering in
                guard let self = self, let panel = panel else { return }
                if isHovering {
                    panel.alphaValue = 0.1
                    panel.ignoresMouseEvents = true
                    self.keyboardMonitor = NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) { [weak panel] event in
                        guard let panel = panel else { return }
                        if event.modifierFlags.contains(.command) {
                            panel.ignoresMouseEvents = false
                            panel.alphaValue = 1
                        }
                    }
                } else {
                    panel.alphaValue = 1
                    panel.ignoresMouseEvents = false
                    if let monitor = self.keyboardMonitor {
                        NSEvent.removeMonitor(monitor)
                        self.keyboardMonitor = nil
                    }
                }
            }

        panel.contentView = NSHostingView(rootView: contentView)
        panel.makeKeyAndOrderFront(nil)
        panel.orderFrontRegardless()

        window = panel
    }
}

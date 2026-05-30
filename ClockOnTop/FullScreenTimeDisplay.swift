//
//  FullScreenTimeDisplay.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI

struct FullScreenTimeDisplay: View {
    @EnvironmentObject var settings: UserSettings
    @State private var currentTime: String = ""
    @State private var isShowingSettings = false
    @State private var tickWorkItem: DispatchWorkItem?
    @State private var isActive = false

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()

    private static let sampleTimeString: String = {
        let sampleDate = Calendar.current.date(from: DateComponents(hour: 22, minute: 58, second: 58))!
        return timeFormatter.string(from: sampleDate)
    }()

    var body: some View {
        GeometryReader { geometry in
            let fontSize = adaptiveFontSize(for: geometry.size)
            ZStack {
                Text(currentTime)
                    .foregroundColor(settings.currentTheme.textColor)
                    .font(.custom(settings.fontFamily, size: fontSize))
                    .lineLimit(1)
                    .offset(y: verticalOffset(fontName: settings.fontFamily, fontSize: fontSize))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(settings.currentTheme.backgroundColor)
            )
            .contextMenu {
                Button("设置") {
                    isShowingSettings = true
                }
            }
        }
        .frame(minWidth: 180, minHeight: 50)
        .onAppear {
            isActive = true
            currentTime = Self.timeFormatter.string(from: Date())
            scheduleTick()
        }
        .onDisappear {
            isActive = false
            tickWorkItem?.cancel()
            tickWorkItem = nil
        }
        .popover(isPresented: $isShowingSettings) {
            SettingsDialog()
                .environmentObject(settings)
        }
    }

    private func scheduleTick() {
        guard isActive else { return }

        let now = Date()
        let nanoseconds = Calendar.current.component(.nanosecond, from: now)
        let delay = Double(1_000_000_000 - nanoseconds) / 1_000_000_000.0

        let item = DispatchWorkItem {
            guard self.isActive else { return }
            self.currentTime = Self.timeFormatter.string(from: Date())
            self.scheduleTick()
        }

        tickWorkItem?.cancel()
        tickWorkItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
    }

    private func adaptiveFontSize(for size: CGSize) -> CGFloat {
        let maxHeight = size.height * 0.92
        let maxWidth = size.width * 0.92
        let fontName = settings.fontFamily
        let text = Self.sampleTimeString

        var low: CGFloat = 8
        var high: CGFloat = maxHeight
        var best: CGFloat = 8

        while low <= high {
            let mid = (low + high) / 2
            guard let font = NSFont(name: fontName, size: mid) else { break }
            let textSize = (text as NSString).size(withAttributes: [.font: font])

            if textSize.width <= maxWidth && textSize.height <= maxHeight {
                best = mid
                low = mid + 0.5
            } else {
                high = mid - 0.5
            }
        }

        return best
    }

    private func verticalOffset(fontName: String, fontSize: CGFloat) -> CGFloat {
        guard let font = NSFont(name: fontName, size: fontSize) else { return 0 }
        let bboxCenter = (font.ascender + font.descender) / 2
        let visualCenter = font.capHeight / 2
        return visualCenter - bboxCenter
    }
}

struct FullScreenTimeDisplay_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenTimeDisplay()
            .environmentObject(UserSettings())
    }
}

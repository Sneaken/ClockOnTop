//
//  FullScreenTimeDisplay.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI
import Combine

struct FullScreenTimeDisplay: View {
    @EnvironmentObject var settings: UserSettings
    @State private var currentTime: String = ""
    @State private var isShowingSettings = false
    @State private var timerCancellable: AnyCancellable?

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter
    }()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text(currentTime)
                    .foregroundColor(settings.currentTheme.textColor)
                    .font(.custom(settings.fontFamily, size: adaptiveFontSize(for: geometry.size)))
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
            currentTime = Self.timeFormatter.string(from: Date())
            timerCancellable = alignToNextSecond()
        }
        .onDisappear {
            timerCancellable?.cancel()
        }
        .popover(isPresented: $isShowingSettings) {
            SettingsDialog()
                .environmentObject(settings)
        }
    }

    private func adaptiveFontSize(for size: CGSize) -> CGFloat {
        let maxHeight = size.height * 0.92
        let maxWidth = size.width * 0.92
        let fontName = settings.fontFamily
        let text = currentTime.isEmpty ? "00:00:00" : currentTime

        var low: CGFloat = 8
        var high: CGFloat = maxHeight
        var best: CGFloat = 8

        while low <= high {
            let mid = (low + high) / 2
            guard let font = NSFont(name: fontName, size: mid) else { break }
            let textWidth = (text as NSString).size(withAttributes: [.font: font]).width

            if textWidth <= maxWidth {
                best = mid
                low = mid + 0.5
            } else {
                high = mid - 0.5
            }
        }

        return best
    }

    private func alignToNextSecond() -> AnyCancellable {
        let now = Date()
        let nanoseconds = Calendar.current.component(.nanosecond, from: now)
        let delay = Double(1_000_000_000 - nanoseconds) / 1_000_000_000.0

        return Just(())
            .delay(for: .seconds(delay), scheduler: RunLoop.main)
            .handleEvents(receiveOutput: { _ in
                currentTime = Self.timeFormatter.string(from: Date())
            })
            .flatMap { _ in
                Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
            .sink { _ in
                currentTime = Self.timeFormatter.string(from: Date())
            }
    }

}

struct FullScreenTimeDisplay_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenTimeDisplay()
            .environmentObject(UserSettings())
    }
}

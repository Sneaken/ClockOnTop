//
//  SettingsDialog.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI

struct SettingsDialog: View {
    @EnvironmentObject var settings: UserSettings
    @State private var selectedFont: String = ""
    @State private var selectedTheme: String = ""
    @State private var monospacedFonts: [String] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("主题")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.secondary)
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 8)

            let columns = [GridItem(.adaptive(minimum: 56, maximum: 64), spacing: 8)]

            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(AppTheme.allThemes) { theme in
                        Button {
                            selectedTheme = theme.id
                            settings.themeId = theme.id
                        } label: {
                            VStack(spacing: 4) {
                                Circle()
                                    .fill(theme.textColor)
                                    .frame(width: 22, height: 22)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedTheme == theme.id ? Color.accentColor : Color.clear, lineWidth: 2)
                                    )

                                Text(theme.name)
                                    .font(.system(size: 10))
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .frame(minWidth: 56)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(selectedTheme == theme.id ? Color.accentColor.opacity(0.1) : Color.clear)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 12)
            }
            .frame(height: 140)
            .padding(.bottom, 8)

            Text("字体")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.secondary)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)

            List(monospacedFonts, id: \.self) { fontName in
                HStack(spacing: 10) {
                    Text("Aa")
                        .font(.custom(fontName, size: 16))
                        .frame(width: 32, alignment: .center)

                    Text(fontName)
                        .font(.system(size: 13))
                        .lineLimit(1)

                    Spacer()

                    if fontName == selectedFont {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(fontName == selectedFont ? Color.accentColor.opacity(0.1) : Color.clear)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFont = fontName
                    settings.fontFamily = fontName
                }
            }
            .listStyle(.plain)
            .frame(height: 300)
        }
        .frame(width: 340)
        .onAppear {
            if monospacedFonts.isEmpty {
                monospacedFonts = loadMonospacedFonts()
            }
            selectedFont = settings.fontFamily
            selectedTheme = settings.themeId
        }
    }

    private func loadMonospacedFonts() -> [String] {
        let manager = NSFontManager.shared
        let families = manager.availableFontFamilies

        return families.compactMap { family -> String? in
            guard let members = manager.availableMembers(ofFontFamily: family) else { return nil }
            for member in members {
                guard let psName = member[0] as? String else { continue }
                guard let font = NSFont(name: psName, size: 12) else { continue }
                let traits = manager.traits(of: font)
                if traits.contains(.fixedPitchFontMask) {
                    return psName
                }
            }
            return nil
        }.sorted()
    }
}

struct SettingsDialog_Previews: PreviewProvider {
    static var previews: some View {
        SettingsDialog()
            .environmentObject(UserSettings())
    }
}

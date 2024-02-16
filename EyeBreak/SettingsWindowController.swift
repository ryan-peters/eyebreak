//
//  SettingsWindowController.swift
//  EyeBreak
//
//  Created by Ryan Peters on 2/6/24.
//

import SwiftUI
import AppKit

class SettingsWindowController: BaseWindowController<SettingsView> {
    init() {
        super.init(contentView: SettingsView(settings: Settings()), windowTitle: "EyeBreak Settings")
    }
}

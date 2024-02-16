//
//  AboutWindowController.swift
//  EyeBreak
//
//  Created by Ryan Peters on 2/5/24.
//

import SwiftUI
import AppKit

class AboutWindowController: BaseWindowController<AboutView> {
    init() {
        super.init(contentView: AboutView(),
                   windowTitle: "About EyeBreak",
                   contentRect: NSRect(x: 0, y: 0, width: 480, height: 550))
    }
}

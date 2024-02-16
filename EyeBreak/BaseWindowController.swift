//
//  BaseWindowController.swift
//  EyeBreak
//
//  Created by Ryan Peters on 2/16/24.
//

import SwiftUI
import AppKit

class BaseWindowController<ContentView: View>: NSObject, NSWindowDelegate {
    private var window: NSWindow?
    private var contentView: ContentView

    init(contentView: ContentView, windowTitle: String, contentRect: NSRect = NSRect(x: 0, y: 0, width: 480, height: 300)) {
        self.contentView = contentView
        super.init()
        createWindow(windowTitle: windowTitle, contentRect: contentRect)
    }

    private func createWindow(windowTitle: String, contentRect: NSRect) {
        let hostingController = NSHostingController(rootView: contentView)
        window = NSWindow(
            contentRect: contentRect,
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered, defer: false)
        window?.center()
        window?.setFrameAutosaveName(windowTitle)
        window?.contentView = hostingController.view
        window?.title = windowTitle
        window?.delegate = self
        window?.isReleasedWhenClosed = false
    }

    func showWindow() {
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}

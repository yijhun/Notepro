import SwiftUI
import WebKit

#if os(macOS)
import AppKit
typealias PlatformViewRepresentable = NSViewRepresentable
#elseif os(iOS)
import UIKit
typealias PlatformViewRepresentable = UIViewRepresentable
#endif

struct MarkdownWebView: PlatformViewRepresentable {
    let markdown: String

    // We need to pass the coordinator to the view to handle delegate methods
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: MarkdownWebView
        var isLoaded: Bool = false
        var pendingMarkdown: String?

        init(_ parent: MarkdownWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoaded = true
            if let markdown = pendingMarkdown {
                updateContent(in: webView, with: markdown)
                pendingMarkdown = nil
            } else {
                updateContent(in: webView, with: parent.markdown)
            }
        }

        func updateContent(in webView: WKWebView, with markdown: String) {
            // Encode markdown to JSON string for safe injection
            guard let data = try? JSONEncoder().encode(markdown),
                  let jsonString = String(data: data, encoding: .utf8) else {
                return
            }

            let js = "window.updateContent(\(jsonString));"
            webView.evaluateJavaScript(js, completionHandler: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    #if os(macOS)
    func makeNSView(context: Context) -> WKWebView {
        return createWebView(context: context)
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        updateWebView(nsView, context: context)
    }
    #elseif os(iOS)
    func makeUIView(context: Context) -> WKWebView {
        return createWebView(context: context)
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        updateWebView(uiView, context: context)
    }
    #endif

    private func createWebView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)

        #if os(macOS)
        webView.setValue(false, forKey: "drawsBackground")
        #else
        webView.isOpaque = false
        webView.backgroundColor = .clear
        #endif

        webView.navigationDelegate = context.coordinator

        // Load the template
        let html = MarkdownHTML.generateTemplate()
        webView.loadHTMLString(html, baseURL: nil)

        return webView
    }

    private func updateWebView(_ webView: WKWebView, context: Context) {
        if context.coordinator.isLoaded {
            context.coordinator.updateContent(in: webView, with: markdown)
        } else {
            // If not loaded, store it as pending
            context.coordinator.pendingMarkdown = markdown
        }
    }
}

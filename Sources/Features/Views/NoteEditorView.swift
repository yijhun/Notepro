import SwiftUI
import Models

public struct NoteEditorView: View {
    @Bindable var note: Note

    // State to toggle between Edit and Preview modes (mainly for iOS/compact)
    @State private var isEditing: Bool = true

    // Environment to detect size class or device type
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    public init(note: Note) {
        self.note = note
    }

    public var body: some View {
        Group {
            #if os(macOS)
            splitLayout
            #else
            if horizontalSizeClass == .regular && verticalSizeClass == .regular {
                splitLayout
            } else {
                tabLayout
            }
            #endif
        }
        .navigationTitle("Edit Note")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    // Split layout for macOS and iPadOS (Regular/Regular)
    private var splitLayout: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                // Editor Side
                VStack(alignment: .leading, spacing: 0) {
                    TextField("Title", text: $note.title)
                        .font(.title)
                        .padding()
                        .background(Color.gray.opacity(0.1))

                    TextEditor(text: $note.content)
                        .font(.body)
                        .padding(4)
                        .frame(maxHeight: .infinity)
                }
                .frame(width: geometry.size.width / 2)

                Divider()

                // Preview Side
                MarkdownWebView(markdown: note.content)
                    .frame(width: geometry.size.width / 2)
            }
        }
    }

    // Tab/Toggle layout for Compact iOS
    private var tabLayout: some View {
        VStack(spacing: 0) {
            Picker("Mode", selection: $isEditing) {
                Text("Edit").tag(true)
                Text("Preview").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if isEditing {
                VStack(alignment: .leading, spacing: 0) {
                    TextField("Title", text: $note.title)
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.1))

                    TextEditor(text: $note.content)
                        .padding(4)
                        .frame(maxHeight: .infinity)
                }
            } else {
                MarkdownWebView(markdown: note.content)
            }
        }
    }
}

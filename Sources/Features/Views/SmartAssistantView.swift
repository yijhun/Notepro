import SwiftUI
import Models

public struct SmartAssistantView: View {
    @Bindable var note: Note
    @State private var aiService = LocalAIService()
    @Environment(\.dismiss) private var dismiss

    public init(note: Note) {
        self.note = note
    }

    public var body: some View {
        NavigationStack {
            List {
                Section(header: Text("AI Actions")) {
                    Button {
                        Task {
                            await aiService.summarize(note: note)
                        }
                    } label: {
                        Label("Summarize Note", systemImage: "text.quote")
                    }
                    .disabled(aiService.isProcessing)

                    Button {
                        Task {
                            await aiService.extractActionItems(note: note)
                        }
                    } label: {
                        Label("Extract Action Items", systemImage: "checklist")
                    }
                    .disabled(aiService.isProcessing)
                }

                if aiService.isProcessing {
                    HStack {
                        ProgressView()
                        Text("Thinking...")
                            .foregroundStyle(.secondary)
                    }
                    .listRowBackground(Color.clear)
                }

                if let summary = aiService.lastSummary {
                    Section(header: Text("Summary")) {
                        Text(summary)
                            .font(.body)
                    }
                }

                if !aiService.extractedActions.isEmpty {
                    Section(header: Text("Potential Actions")) {
                        ForEach(aiService.extractedActions, id: \.self) { action in
                            HStack {
                                Text(action)
                                Spacer()
                                Button("Add") {
                                    // Logic to add to Task model would go here
                                    // For now, just print
                                    print("Added task: \(action)")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Smart Assistant")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

import Foundation
import Models
import Observation

public protocol LLMProvider {
    func generateSummary(for text: String) async throws -> String
    func extractActions(from text: String) async throws -> [String]
}

// Mock Provider for "Plug-and-play" architecture
public struct MockLLMProvider: LLMProvider {
    public init() {}

    public func generateSummary(for text: String) async throws -> String {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return "This is a smart summary of your note. It highlights key points and insights derived from the text using local AI."
    }

    public func extractActions(from text: String) async throws -> [String] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return ["Follow up on research", "Draft the next chapter", "Review citations"]
    }
}

@Observable
public class LocalAIService {
    public var provider: LLMProvider
    public var isProcessing: Bool = false
    public var lastSummary: String?
    public var extractedActions: [String] = []

    public init(provider: LLMProvider = MockLLMProvider()) {
        self.provider = provider
    }

    public func summarize(note: Note) async {
        isProcessing = true
        defer { isProcessing = false }

        do {
            let summary = try await provider.generateSummary(for: note.content)
            await MainActor.run {
                self.lastSummary = summary
            }
        } catch {
            print("AI Summarization failed: \(error)")
        }
    }

    public func extractActionItems(note: Note) async {
        isProcessing = true
        defer { isProcessing = false }

        do {
            let actions = try await provider.extractActions(from: note.content)
            await MainActor.run {
                self.extractedActions = actions
            }
        } catch {
            print("AI Extraction failed: \(error)")
        }
    }
}

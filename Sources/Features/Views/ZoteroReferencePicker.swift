import SwiftUI
import Combine
import Models

public struct ZoteroReferencePicker: View {
    @State private var items: [ZoteroReference] = []
    @State private var searchText = ""
    @Binding var selectedReference: ZoteroReference?
    @Environment(\.dismiss) private var dismiss

    // In a real app, inject this via environment
    private let service = ZoteroService.shared

    public init(selectedReference: Binding<ZoteroReference?>) {
        self._selectedReference = selectedReference
    }

    public var body: some View {
        NavigationStack {
            List(items) { item in
                Button {
                    selectedReference = item
                    dismiss()
                } label: {
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.authors.joined(separator: ", "))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Select Reference")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Fetch") {
                        fetchData()
                    }
                }
            }
        }
        .onAppear {
            // Pre-load mock data or fetch
            fetchData()
        }
    }

    private func fetchData() {
        // Trigger fetch. In a real view, handle subscription lifecycle properly.
        // Using sink here for simplicity in this snippet.
        _ = service.fetchItems()
            .replaceError(with: [])
            .sink { fetchedItems in
                self.items = fetchedItems
            }
    }
}

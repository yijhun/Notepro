import SwiftUI
import SwiftData
import Models

public struct GraphView: View {
    @Query private var notes: [Note]
    @State private var offset: CGSize = .zero
    @State private var scale: CGFloat = 1.0

    // Simple node structure for layout
    struct NodeLayout: Identifiable {
        let id: UUID
        let title: String
        var position: CGPoint
        let links: [UUID]
    }

    @State private var layout: [NodeLayout] = []

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                // Draw Connections
                for node in layout {
                    for linkedID in node.links {
                        if let target = layout.first(where: { $0.id == linkedID }) {
                            var path = Path()
                            path.move(to: node.position)
                            path.addLine(to: target.position)
                            context.stroke(path, with: .color(.gray.opacity(0.5)), lineWidth: 1)
                        }
                    }
                }

                // Draw Nodes
                for node in layout {
                    let rect = CGRect(x: node.position.x - 20, y: node.position.y - 20, width: 40, height: 40)
                    context.fill(Path(ellipseIn: rect), with: .color(.blue))

                    // Draw Text
                    let text = Text(node.title).font(.caption)
                    context.draw(text, at: CGPoint(x: node.position.x, y: node.position.y + 30), anchor: .center)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
            )
            .scaleEffect(scale)
            .onAppear {
                calculateLayout(in: geometry.size)
            }
        }
        .navigationTitle("Knowledge Graph")
    }

    private func calculateLayout(in size: CGSize) {
        // Very basic random layout for demonstration.
        // In a real app, use a Force-Directed Graph algorithm (d3-force equivalent).
        layout = notes.map { note in
            NodeLayout(
                id: note.id,
                title: note.title,
                position: CGPoint(
                    x: CGFloat.random(in: 50...(size.width - 50)),
                    y: CGFloat.random(in: 50...(size.height - 50))
                ),
                links: note.linkedNotes?.map { $0.id } ?? []
            )
        }
    }
}

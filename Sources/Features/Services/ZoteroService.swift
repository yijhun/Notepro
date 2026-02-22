import Foundation
import Combine
import Models

/// Service for fetching Zotero data.
public final class ZoteroService {
    public static let shared = ZoteroService()

    // Constants for Zotero API
    private let baseURL = "https://api.zotero.org"
    private let userPrefix = "/users/"
    private let itemsEndpoint = "/items"

    // Authentication
    // In a real app, this key would be securely stored in Keychain
    private var apiKey: String?
    private var userID: String?

    private init() {}

    /// Authenticates the user with their Zotero User ID and API Key.
    /// - Parameters:
    ///   - userID: The user's Zotero ID.
    ///   - apiKey: The user's Zotero API Key.
    public func authenticate(userID: String, apiKey: String) {
        self.userID = userID
        self.apiKey = apiKey
    }

    /// Fetches items (references) from the user's Zotero library using the Web API.
    /// - Returns: A publisher that emits an array of ZoteroReference or an error.
    public func fetchItems() -> AnyPublisher<[ZoteroReference], Error> {
        guard let userID = userID, let apiKey = apiKey else {
            return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
        }

        // Example URL: https://api.zotero.org/users/12345/items?format=json
        let urlString = "\(baseURL)\(userPrefix)\(userID)\(itemsEndpoint)?format=json&limit=50"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("Zotero-API-Version: 3", forHTTPHeaderField: "Zotero-API-Version")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [ZoteroItem].self, decoder: JSONDecoder())
            .map { items in
                // Map API response to our Model
                items.map { item in
                    ZoteroReference(
                        zoteroID: item.key,
                        title: item.data.title,
                        authors: item.data.creators?.map { "\($0.firstName ?? "") \($0.lastName ?? "")" } ?? [],
                        abstract: item.data.abstractNote,
                        url: URL(string: item.data.url ?? "")
                    )
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Local SQLite Support (macOS)

    #if os(macOS)
    public func readLocalDatabase(at path: String) -> [ZoteroReference] {
        // This is a placeholder for direct SQLite access.
        // In a real implementation, you would use `SQLite.swift` or `sqlite3` API.
        // Reading `zotero.sqlite` directly requires understanding the schema:
        // items table, itemData table, itemDataValues table.

        print("Attempting to read local Zotero database at: \(path)")

        // Mock return for now since we don't have the SQLite library dependency.
        return [
            ZoteroReference(zoteroID: "local_1", title: "Local Paper A", authors: ["Smith, J."]),
            ZoteroReference(zoteroID: "local_2", title: "Local Paper B", authors: ["Doe, A."])
        ]
    }
    #endif
}

// MARK: - API Response Models

struct ZoteroItem: Codable {
    let key: String
    let data: ZoteroItemData
}

struct ZoteroItemData: Codable {
    let title: String
    let abstractNote: String?
    let url: String?
    let creators: [ZoteroCreator]?
}

struct ZoteroCreator: Codable {
    let firstName: String?
    let lastName: String?
}

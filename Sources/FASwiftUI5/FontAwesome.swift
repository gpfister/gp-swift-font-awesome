//
//  swift-font-awesome
//
//  Created by Matt Maddux on 10/1/19.
//  Copyright © 2019 Matt Maddux. All rights reserved.
//

import SwiftUI

public class FontAwesome {
    // ======================================================= //

    // MARK: - Shared Instance

    // ======================================================= //

    public static var shared: FontAwesome = .init()

    // ======================================================= //

    // MARK: - Published Properties

    // ======================================================= //

    public private(set) var store: [String: FAIcon]

    // ======================================================= //

    // MARK: - Initializer

    // ======================================================= //

    init() {
        let fileURL = Bundle.main.url(forResource: "icons", withExtension: "json")!
        let jsonString = try! String(contentsOf: fileURL, encoding: .utf8)
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        store = try! decoder.decode([String: FAIcon].self, from: jsonData)
        for key in store.keys {
            store[key]!.id = key
        }
    }

    // ======================================================= //

    // MARK: - Methods

    // ======================================================= //

    public func icon(byName name: String) -> FAIcon? {
        store[name.lowercased()]
    }

    public func search(query: String) -> [String: FAIcon] {
        let filtered = store.filter {
            if $0.key.contains(query) {
                return true
            } else {
                for term in $0.value.searchTerms {
                    if term.contains(query) {
                        return true
                    }
                }
                return false
            }
        }
        return filtered
    }
}

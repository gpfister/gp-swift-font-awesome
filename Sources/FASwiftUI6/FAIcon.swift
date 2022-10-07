//
//  swift-font-awesome
//
//  Created by Matt Maddux on 10/1/19.
//  Copyright © 2019 Matt Maddux. All rights reserved.
//

import SwiftUI

// ======================================================= //

// MARK: - Style Enum

// ======================================================= //

public enum FAStyle: String, Codable {
    case thin
    case light
    case regular
    case solid
    case sharp
    case brands
    case duotone

    var weight: Font.Weight {
        switch self {
        case .thin:
            return .thin
        case .light:
            return .light
        case .solid:
            return .heavy
        case .sharp:
            return .heavy
        default:
            return .regular
        }
    }
}

// ======================================================= //

// MARK: - Collection Enum

// ======================================================= //

enum FACollection: String {
    case free = "Font Awesome 6 Free"
    case pro = "Font Awesome 6 Pro"
    case sharp = "Font Awesome 6 Sharp"
    case brands = "Font Awesome 6 Brands"

    static var availableCollection: [FACollection] {
        var result = [FACollection]()
        if FACollection.isAvailable(collection: .pro) {
            result.append(.pro)
        }
        if FACollection.isAvailable(collection: .sharp) {
            result.append(.sharp)
        }
        if FACollection.isAvailable(collection: .free) {
            result.append(.free)
        }
        if FACollection.isAvailable(collection: .brands) {
            result.append(.brands)
        }
        return result
    }

    static func isAvailable(collection: FACollection) -> Bool {
        #if os(iOS) || os(watchOS) || os(tvOS)
            return UIFont.familyNames.contains(collection.rawValue)
        #elseif os(macOS)
            return NSFontManager.shared.availableFontFamilies.contains(collection.rawValue)
        #endif
    }
}

// ======================================================= //

// MARK: - Icon Struct

// ======================================================= //

public struct FAIcon: Identifiable, Decodable, Comparable {
    // ======================================================= //

    // MARK: - Properties

    // ======================================================= //

    public var id: String?
    public var label: String
    public var unicode: String
    public var styles: [FAStyle]
    public var searchTerms: [String]

    var collection: FACollection {
        if styles.contains(.brands) {
            return .brands
        } else if styles.contains(.brands) {
            return .sharp
        } else if FACollection.isAvailable(collection: .pro) {
            return .pro
        } else {
            return .free
        }
    }

    var unicodeString: String {
        let rawMutable = NSMutableString(string: "\\u\(unicode)")
        CFStringTransform(rawMutable, nil, "Any-Hex/Java" as NSString, true)
        return rawMutable as String
    }

    // ======================================================= //

    // MARK: - Initializer

    // ======================================================= //

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decode(String.self, forKey: .label)
        unicode = try values.decode(String.self, forKey: .unicode)
        styles = try values.decode([FAStyle].self, forKey: .styles)

        let search = try values.nestedContainer(keyedBy: SearchKeys.self, forKey: .search)
        let rawSearchTerms = try search.decode([RawSearchTerm].self, forKey: .terms)
        searchTerms = [String]()
        for term in rawSearchTerms {
            searchTerms.append(term.toString())
        }
    }

    // ======================================================= //

    // MARK: - Coding Keys

    // ======================================================= //

    public enum CodingKeys: String, CodingKey {
        case label
        case unicode
        case styles
        case search
    }

    public enum SearchKeys: String, CodingKey {
        case terms
    }

    // ======================================================= //

    // MARK: - Decoding Helper Types

    // ======================================================= //

    enum RawSearchTerm: Decodable {
        case int(Int)
        case string(String)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            do {
                self = try .int(container.decode(Int.self))
            } catch DecodingError.typeMismatch {
                do {
                    self = try .string(container.decode(String.self))
                } catch DecodingError.typeMismatch {
                    throw DecodingError.typeMismatch(RawSearchTerm.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload conflicts with expected type, (Int or String)"))
                }
            }
        }

        func toString() -> String {
            switch self {
            case let .int(storedInt):
                return String(storedInt)
            case let .string(storedString):
                return storedString
            }
        }
    }

    // ======================================================= //

    // MARK: - Comparable

    // ======================================================= //

    public static func < (lhs: FAIcon, rhs: FAIcon) -> Bool {
        lhs.id ?? lhs.label < lhs.id ?? rhs.label
    }

    public static func == (lhs: FAIcon, rhs: FAIcon) -> Bool {
        lhs.id ?? lhs.label == lhs.id ?? rhs.label
    }
}

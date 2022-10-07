//
//  swift-font-awesome
//  Copyright © 2019-2021 Matt Maddux. MIT License.
//  Copyright © 2022 Greg PFISTER. MIT License.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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

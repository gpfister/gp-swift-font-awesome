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

public struct FAText: View {
    let iconName: String
    let size: CGFloat
    let style: FAStyle

    private let icon: FAIcon

    public init(iconName: String, size: CGFloat, style: FAStyle? = nil) {
        self.size = size
        self.iconName = iconName.hasPrefix("fa-") ? String(iconName.dropFirst(3)) : iconName

        if let icon = FontAwesome.shared.icon(byName: self.iconName) {
            self.icon = icon
            if let style = style, !icon.styles.contains(style) {
                let fallbackStyle = icon.styles.first!
                if fallbackStyle != .brands {
                    print("FASwiftUI: Style \"\(style)\" not available for icon \"\(iconName)\", using \"\(fallbackStyle)\". Check list at https://fontawesome.com/icons for set availability.")
                } else if style != .regular {
                    print("FASwiftUI: Icon \"\(iconName)\" is part of the brands set and doesn't support alternate styles. Check list at https://fontawesome.com/icons for set availability.")
                }
                self.style = fallbackStyle
            } else {
                self.style = style ?? .regular
            }
        } else {
            icon = FontAwesome.shared.icon(byName: "circle-question")!
            self.style = .regular
            print("FASwiftUI: Icon \"\(iconName)\" not found. Check list at https://fontawesome.com/icons for set availability.")
        }
    }

    private var weight: Font.Weight {
        style.weight
    }

    public var body: some View {
        Text(icon.unicodeString)
            .font(Font.custom(icon.collection.rawValue, size: size))
            .fontWeight(weight)
    }
}

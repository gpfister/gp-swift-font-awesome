//
//  gp-swift-font-awesome
//  Copyright © 2019-2021, Matt Maddux. MIT License.
//  Copyright © 2022-2023, Greg PFISTER. MIT License.
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

public struct GPFAText: View {
    var iconName: String
    private var icon: GPFAIcon
    var size: CGFloat
    var style: GPFAStyle
    private var weight: Font.Weight {
        style.weight
    }

    public init(iconName: String, size: CGFloat, style: GPFAStyle? = nil) {
        self.size = size
        self.style = style ?? .regular
        self.iconName = iconName.hasPrefix("fa-") ? String(iconName.dropFirst(3)) : iconName

        if let icon = GPFontAwesome.shared.icon(byName: self.iconName) {
            self.icon = icon
        } else {
            icon = GPFontAwesome.shared.icon(byName: "question-circle")!
            self.style = .regular
            print("GPFontAwesome5: Icon \"\(iconName)\" not found. Check list at https://fontawesome.com/icons for set availability.")
        }

        if !icon.styles.contains(self.style) {
            let fallbackStyle = icon.styles.first!
            if fallbackStyle != .brands, style != nil {
                print("GPFontAwesome5: Style \"\(style ?? .regular)\" not available for icon \"\(iconName)\", using \"\(fallbackStyle)\". Check list at https://fontawesome.com/icons for set availability.")
            } else if self.style != .regular, style != nil {
                print("GPFontAwesome5: Icon \"\(iconName)\" is part of the brands set and doesn't support alternate styles. Check list at https://fontawesome.com/icons for set availability.")
            }
            self.style = fallbackStyle
        }
    }

    public var body: some View {
        Text(icon.unicodeString)
            .font(Font.custom(icon.collection.rawValue, size: size))
            .fontWeight(weight)
    }
}

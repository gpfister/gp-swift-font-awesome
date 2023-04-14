// swift-tools-version:5.8
//
//  gp-swift-font-awesome
//  Copyright © 2019-2021 Matt Maddux. MIT License.
//  Copyright © 2022- Greg PFISTER. MIT License.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import PackageDescription

let package = Package(
    name: "GPFontAwesome",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "GPFontAwesome5",
            targets: ["GPFontAwesome5"]
        ),
        .library(
            name: "GPFontAwesome6",
            targets: ["GPFontAwesome6"]
        ),
    ],
    targets: [
        .target(
            name: "GPFontAwesome5"
        ),
        .target(
            name: "GPFontAwesome6"
        ),
    ]
)

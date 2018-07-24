//
// 7/10/18
//

import UIKit

// Original: https://stackoverflow.com/questions/46479288/swift-safe-area-layout-guide-and-visual-format-language
extension NSLayoutConstraint {
    private static let stubKey = "___STUB"
    static func safeAreaConstraints(withVisualFormat format: String,
                                    options: NSLayoutFormatOptions = [],
                                    metrics: [String : Any]?,
                                    views: [String : Any]) -> [NSLayoutConstraint] {
        guard #available(iOS 11.0, *), format.contains("|>") || format.contains("<|") else {
            let finalVfl = format.replacingOccurrences(of: "|>", with: "|").replacingOccurrences(of: "<|", with: "|")
            return constraints(withVisualFormat: finalVfl, options: options, metrics: metrics, views: views)
        }

        var allViews = views
        let stub = UIView()
        allViews[stubKey] = stub
        let finalVfl = format.replacingOccurrences(of: "|>",
                                                   with: "[\(stubKey)]")
            .replacingOccurrences(of: "<|",
                                  with: "[\(stubKey)]")
        let rawConstraints = constraints(withVisualFormat: finalVfl,
                                         options: options,
                                         metrics: metrics,
                                         views: allViews)

        return rawConstraints.map { c in
            if c.firstItem === stub {
                guard let view = c.secondItem as? UIView else {
                    assert(false, "Second it was not a view \(String(describing: c.secondItem))")
                }
                let newC = NSLayoutConstraint(item: view.superview?.safeAreaLayoutGuide as Any,
                                              attribute: oppositeAttribute(c.firstAttribute),
                                              relatedBy: c.relation,
                                              toItem: view,
                                              attribute: c.secondAttribute,
                                              multiplier: c.multiplier,
                                              constant: c.constant)
                newC.identifier = "FirstItemSafeAreaLayoutGuide"
                newC.priority = c.priority
                return newC
            } else if c.secondItem === stub {
                guard let view = c.firstItem as? UIView else {
                    assert(false, "Second it was not a view \(String(describing: c.firstItem))")
                }
                let newC = NSLayoutConstraint(item: view,
                                              attribute: c.firstAttribute,
                                              relatedBy: c.relation,
                                              toItem: view.superview?.safeAreaLayoutGuide,
                                              attribute: oppositeAttribute(c.secondAttribute),
                                              multiplier: c.multiplier,
                                              constant: c.constant)
                newC.identifier = "SecondItemSafeAreaLayoutGuide"
                newC.priority = c.priority
                return newC
            } else {
                return c
            }
        }
    }

    private static func oppositeAttribute(_ attribute: NSLayoutAttribute) -> NSLayoutAttribute {
        switch (attribute) {
        case .left:
            return .right;
        case .right:
            return .left;
        case .top:
            return .bottom;
        case .bottom:
            return .top;
        case .leading:
            return .trailing
        case .trailing:
            return .leading
        // These two are special cases, we see them when align all X or Y flags are used.
        case .centerX:
            return .centerX;
        case .centerY:
            return .centerY;
        // Nothing more.
        default:
            assert(false, "We don't expect other attributes here")
            return attribute
        }
    }
}

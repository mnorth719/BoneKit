//
// 6/26/18.
//

import UIKit

typealias ConstraintConfiguration = (String, NSLayoutFormatOptions)

extension NSLayoutConstraint {
  static func constraints(withVisualFormat formatString: String,
                          views: [String: Any],
                          options: NSLayoutFormatOptions = [],
                          metrics: [String: Any]? = nil) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.safeAreaConstraints(withVisualFormat: formatString,
                                                  options: options,
                                                  metrics: metrics,
                                                  views: views)
  }

  static func constraints(withVisualFormats formatStrings: [String],
                          views: [String: Any],
                          options: NSLayoutFormatOptions = [],
                          metrics: [String: Any]? = nil) -> [NSLayoutConstraint] {
    return formatStrings.flatMap {
      constraints(withVisualFormat: $0,
                  views: views,
                  options: options,
                  metrics: metrics)
    }
  }

  static func constraints(withConfigs configs: [ConstraintConfiguration],
                          views: [String: Any],
                          metrics: [String: Any]? = nil) -> [NSLayoutConstraint] {
    return configs.flatMap {
      constraints(withVisualFormat: $0.0,
                  views: views,
                  options: $0.1,
                  metrics: metrics)
    }
  }
}

extension Collection where Self.Element == NSLayoutConstraint {
  func activateAll() {
    NSLayoutConstraint.activate(self as! [NSLayoutConstraint])
  }

  func deactivateAll() {
    NSLayoutConstraint.deactivate(self as! [NSLayoutConstraint])
  }
}

extension Collection where Self.Element == [NSLayoutConstraint] {
  func activateAll() {
    forEach { $0.activateAll() }
  }

  func deactivateAll() {
    forEach { $0.deactivateAll() }
  }
}

//
// 6/26/18.
//

import UIKit

extension UIView {
  func forAutolayout() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }

  func addConstraints(_ constraints: [[NSLayoutConstraint]]) {
    addConstraints(constraints.flatMap { $0 })
  }

  @discardableResult func centerInParent() -> Self {
    guard let sv = superview else {
      fatalError("Cannot center in parent if not in superview")
    }

    centerXAnchor.constraint(equalTo: sv.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: sv.centerYAnchor).isActive = true
    return self
  }

  @discardableResult func centerHorizontallyInParent() -> Self {
    guard let sv = superview else {
      fatalError("Cannot center in parent if not in superview")
    }

    centerXAnchor.constraint(equalTo: sv.centerXAnchor).isActive = true
    return self
  }

  @discardableResult func centerVerticallyInParent() -> Self {
    guard let sv = superview else {
      fatalError("Cannot center in parent if not in superview")
    }

    centerYAnchor.constraint(equalTo: sv.centerYAnchor).isActive = true
    return self
  }

  @discardableResult func fitToWidth(_ width: CGFloat) -> Self {
    widthAnchor.constraint(equalToConstant: width).isActive = true
    return self
  }

  @discardableResult func fitToHeight(_ height: CGFloat) -> Self {
    heightAnchor.constraint(equalToConstant: height).isActive = true
    return self
  }

  @discardableResult func fitToSize(_ size: CGSize) -> Self {
    return fitToWidth(size.width).fitToHeight(size.height)
  }

  @discardableResult func pinToParent() -> Self {
    guard let sv = superview else {
      fatalError("Cannot pin to parent if not in superview")
    }

    frame = sv.bounds
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    translatesAutoresizingMaskIntoConstraints = true

    return self
  }

  @discardableResult func matchHeight(_ view: UIView) -> Self {
    heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    return self
  }

  @discardableResult func matchWidth(_ view: UIView) -> Self {
    widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    return self
  }

  @discardableResult func matchSize(_ view: UIView) -> Self {
    widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    return self
  }

  @discardableResult func constrainToSameSizeAs(_ view: UIView) -> [NSLayoutConstraint] {
    return [widthAnchor.constraint(equalTo: view.widthAnchor),
            heightAnchor.constraint(equalTo: view.heightAnchor)]
  }

  @discardableResult func placeBelow(view: UIView, withOffset offset: CGFloat = 0) -> Self {
    topAnchor.constraint(equalTo: view.bottomAnchor, constant: offset).isActive = true
    return self
  }

  @discardableResult func placeAbove(view: UIView, withOffset offset: CGFloat = 0) -> Self {
    bottomAnchor.constraint(equalTo: view.topAnchor, constant: offset).isActive = true
    return self
  }

  func addSubviewsForAutolayout(_ views: UIView...) {
    views.forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
  }

  func addSubviewForAutolayout(_ view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
  }
}

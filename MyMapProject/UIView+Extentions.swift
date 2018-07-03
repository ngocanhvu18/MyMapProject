//
//  UIView+Extentions.swift
//  MyMapProject
//
//  Created by Ngọc Anh on 6/27/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit

@IBDesignable
class DesignImageView: UIImageView {}

@IBDesignable
class DesignableView: UIView {}

@IBDesignable
class DesignableButton: UIButton {}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            if newValue == -1 {
                layer.cornerRadius = frame.width < frame.height ? frame.width * 0.5 : frame.height * 0.5
            } else {
                layer.cornerRadius = newValue
            }
            contentMode = .scaleToFill
            clipsToBounds = true
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    func animate(animations: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.layer.transform = CATransform3DMakeScale(1.25, 1.25, 1);
        }, completion: { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }, completion: { (completed) in
                animations(completed)
            })
        })
        
    }
    func animateToSmaller(animations: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.layer.transform = CATransform3DMakeScale(0.75, 0.75, 1);
        }, completion: { (completed) in
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }, completion: { (completed) in
                animations(completed)
            })
        })
        
    }
}
fileprivate class Keys {
    static let TOP_BORDER = "top-border"
    static let BOTTOM_BORDER = "bottom-border"
    static let LEFT_BORDER = "left-border"
    static let RIGHT_BORDER = "right-boder"
}

extension UIView {
    
    @IBInspectable var topBorder: Bool {
        get {
            return layer.value(forKey: Keys.TOP_BORDER) != nil
        }
        set {
            addTopBorder(isActive: newValue)
        }
    }
    
    func addTopBorder(isActive: Bool, height: CGFloat = 1) {
        if isActive {
            // add top border
            let border = UIView(frame: CGRect(x: 0, y: 0, width: layer.frame.width, height: height))
            border.layer.name = Keys.TOP_BORDER
            border.backgroundColor = UIColor.blue
            layer.setValue(border, forKey: Keys.TOP_BORDER)
            addSubview(border)
        }
        else {
            if let border = layer.value(forKey: Keys.TOP_BORDER) as? UIView {
                border.removeFromSuperview()
                layer.setValue(nil, forKey: Keys.TOP_BORDER)
            }
        }
    }
    
    @IBInspectable var bottomBorder: Bool {
        get {
            return layer.value(forKey: Keys.BOTTOM_BORDER) != nil
        }
        set {
            addBottomBorder(isActive: newValue)
        }
    }
    
    func addBottomBorder(isActive: Bool, height: CGFloat = 1) {
        if isActive {
            // add top border
            let border = UIView(frame: CGRect(x: 0, y: layer.frame.height - height, width: layer.frame.width, height: height))
            border.layer.name = Keys.BOTTOM_BORDER
            border.backgroundColor = UIColor.blue
            layer.setValue(border, forKey: Keys.BOTTOM_BORDER)
            addSubview(border)
        }
        else {
            if let border = layer.value(forKey: Keys.BOTTOM_BORDER) as? UIView {
                border.removeFromSuperview()
                layer.setValue(nil, forKey: Keys.BOTTOM_BORDER)
            }
        }
    }
    @IBInspectable var leftBorder: Bool {
        get {
            return layer.value(forKey: Keys.LEFT_BORDER) != nil
        }
        set {
            addLeftBorder(isActive: newValue)
        }
    }
    
    func addLeftBorder(isActive: Bool, width: CGFloat = 1) {
        if isActive {
            // add top border
            let border = UIView(frame: CGRect(x: 0, y: 0, width: width, height: layer.frame.height))
            border.layer.name = Keys.LEFT_BORDER
            border.backgroundColor = UIColor.blue
            layer.setValue(border, forKey: Keys.LEFT_BORDER)
            addSubview(border)
        }
        else {
            if let border = layer.value(forKey: Keys.LEFT_BORDER) as? UIView {
                border.removeFromSuperview()
                layer.setValue(nil, forKey: Keys.LEFT_BORDER)
            }
        }
    }
    @IBInspectable var rightBorder: Bool {
        get {
            return layer.value(forKey: Keys.RIGHT_BORDER) != nil
        }
        set {
            addRightBorder(isActive: newValue)
        }
    }
    
    func addRightBorder(isActive: Bool, width: CGFloat = 1) {
        if isActive {
            // add top border
            let border = UIView(frame: CGRect(x: layer.frame.width - width, y: 0, width: width, height: layer.frame.height))
            border.layer.name = Keys.RIGHT_BORDER
            border.backgroundColor = UIColor.blue
            layer.setValue(border, forKey: Keys.RIGHT_BORDER)
            addSubview(border)
        }
        else {
            if let border = layer.value(forKey: Keys.RIGHT_BORDER) as? UIView {
                border.removeFromSuperview()
                layer.setValue(nil, forKey: Keys.RIGHT_BORDER)
            }
        }
    }
}

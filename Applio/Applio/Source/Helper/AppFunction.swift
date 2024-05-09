//
//  AppFunction.swift
//  Applio
//
//  Created by Vasu Savaliya on 09/05/24.
//

import Foundation
import UIKit

/* you want to add some action in main thread then use delay */
public func delay(_ delay: Double = 0.2, closure: @escaping () -> ()) {
    DispatchQueue.main.async {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}

public func debugPrint(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
    let fileName = URL(fileURLWithPath: file).lastPathComponent
    print("[\(fileName):\(line) - \(function)] \(message)")
}

public func vc<T: UIViewController>(vcKind: T.Type? = nil) -> T? {
    guard let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window else { return nil }
    if let vc = window?.rootViewController as? T {
        return vc
    } else if let vc = window?.rootViewController?.presentedViewController as? T {
        return vc
    } else if let vc = window?.rootViewController?.children {
        return vc.lazy.compactMap { $0 as? T }.first
    }
    return nil
}

/* you got root view controller */
public func getRootViewController() -> UIViewController? {
//    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//    return appDelegate.window?.rootViewController
    
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    return nil
    
}

public func showGlobelAlert(title: String? = "Confirmation"/*(Bundle.main.displayName ?? "")*/,
                     msg: String,
                     doneButtonTitle: String? = "Okay",
                     cancelButtonTitle: String? = "",
                     doneAction: ((Bool) -> Void)? = nil,
                     cancelAction: ((Bool) -> Void)? = nil) {
    
    let dialogMessage = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    
    dialogMessage.addAction(UIAlertAction(title: doneButtonTitle, style: .default, handler: { action in
        print("action done handler")
        doneAction?(true)
    }))
    if cancelButtonTitle != "" {
        dialogMessage.addAction(UIAlertAction(title: cancelButtonTitle, style: .destructive, handler: { action in
            print("action cancel handler")
            cancelAction?(true)
        }))
    }
    UIApplication.shared.keyWindow?.rootViewController?.present(dialogMessage, animated: true, completion: nil)
}


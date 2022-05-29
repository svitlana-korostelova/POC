//
//  ToastMessageViewController.swift
//
//
//  Created by Svitlana Korostelova on 09.11.2021.
//

import UIKit

public protocol ToastMessagesProtocol {
    func show(message content: ToastMessageType<String>)
    func show(with messageType: ToastMessageType<String>, in parentViewController: ToastMessageRootViewProtocol, bottomOffset: CGFloat)
    func showOfflineMessage(message type: ToastMessageType<String>)
    var offlineErrorViewTag: Int { get }
}

public final class BottomToastMessagesView: UIView {}

public extension ToastMessagesProtocol {
    func show(with messageType: ToastMessageType<String>, in parentViewController: ToastMessageRootViewProtocol, bottomOffset: CGFloat) {
        guard let parentViewController = parentViewController as? UIViewController else { return }
        let childViewController = messageType.viewController
        if let childViewController = childViewController as? ToastMessageViewProtocol {
            childViewController.bottomOffset = bottomOffset
        }
        parentViewController.addChild(childViewController)
        childViewController.view.frame = parentViewController.view.bounds
        parentViewController.view.addSubview(childViewController.view)
        childViewController.didMove(toParent: parentViewController)
        childViewController.animateAppearanceOfToastMessages()
    }

    func showOfflineMessage(message type: ToastMessageType<String>) {
        let viewController = type.viewController
        let window = UIApplication.shared.windows.filter(\.isKeyWindow).first
        viewController.view.tag = offlineErrorViewTag
        guard viewController.view is BottomToastMessagesView else { return }
        window?.addSubview(viewController.view)
    }

    func removeOfflineErrorView() {
        let window = UIApplication.shared.windows.filter(\.isKeyWindow).first
        let view = window?.subviews.first(where: { $0.tag == offlineErrorViewTag })
        view?.removeFromSuperview()
    }
}

public protocol ToastMessageRootViewProtocol {
    var toastMessageBottomOffset: CGFloat { get }
}

public class ToastMessages: ToastMessagesProtocol {
    private init() {}

    public let offlineErrorViewTag = 5000
    public static var shared: ToastMessagesProtocol = ToastMessages()

    public func show(message type: ToastMessageType<String>) {
        let viewController = type.viewController
        let window = UIApplication.shared.windows.filter(\.isKeyWindow).first
        window?.addSubview(viewController.view)
        viewController.animateAppearanceOfToastMessages()
    }
}

public enum ToastMessageType<T: Hashable> {
    case mergeSuccess(T)
    case mergeFailure(T)
    case noBarcodeFounded(T)
    case loadingError(T)

    public var value: T {
        switch self {
        case let .mergeSuccess(value), let .mergeFailure(value), let .noBarcodeFounded(value), let .loadingError(value):
            return value
        }
    }
}

public extension ToastMessageType where T == String {
    var viewController: UIViewController {
        let viewController: UIViewController
        switch self {
        case .mergeSuccess, .mergeFailure, .noBarcodeFounded, .loadingError:
            viewController = BottomToastMessagesViewController.viewController
            if let currentViewController = viewController as? BottomToastMessagesViewController {
                currentViewController.content = self
            }
        }
        return viewController
    }
}

protocol ToastMessageViewProtocol: AnyObject {
    static var viewController: UIViewController { get }
    var content: ToastMessageType<String>! { get set }
    var bottomOffset: CGFloat? { get set }
}

extension ToastMessageViewProtocol {
    static var storyboardName: String {
        "ToastMessageViewController"
    }
}

extension UIViewController {
    func animateAppearanceOfToastMessages() {
        let time = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}

extension UIStoryboard {
        static func instantiateViewController<ViewControllerType: UIViewController>(storyboardName: String,
                                                                                    ofType _: ViewControllerType.Type,
                                                                                    isInitial: Bool = false,
                                                                                    in bundle: Bundle? = nil) -> ViewControllerType
        {
            let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
            let identifier = String(describing: ViewControllerType.self)
            let viewController = isInitial ?
                storyboard.instantiateInitialViewController() :
                storyboard.instantiateViewController(withIdentifier: identifier)
            return viewController as! ViewControllerType
        }
}

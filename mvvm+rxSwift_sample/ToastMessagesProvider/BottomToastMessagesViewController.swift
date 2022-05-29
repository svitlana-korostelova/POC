//
//  BottomToastMessagesViewController.swift
//  MAFToastMessage
//
//  Created by Svitlana Korostelova on 03.11.2021.

//

import Foundation
import UIKit

public final class BottomToastMessagesViewController: UIViewController, ToastMessageViewProtocol {
    var content: ToastMessageType<String>!
    var bottomOffset: CGFloat?

    @IBOutlet private var toastMessageView: UIView!
    @IBOutlet private var toastMessageLabel: UILabel!
    @IBOutlet private var toastMessageImageView: UIImageView!
    @IBOutlet private var toastMessageViewBottomConstraint: NSLayoutConstraint!

    override public func viewDidLoad() {
        super.viewDidLoad()

        customizeUI(for: content)
        toastMessageLabel.text = NSLocalizedString(content.value, comment: "")
        if let heightFromBottom = bottomOffset {
            toastMessageViewBottomConstraint.constant = heightFromBottom
        }
    }

    private func customizeUI(for messageType: ToastMessageType<String>) {
        switch messageType {
        case .mergeSuccess:
            toastMessageView.backgroundColor = UIColor(red: 0 / 255.0, green: 121 / 255.0, blue: 43 / 255.0, alpha: 1.0)
            toastMessageLabel.textColor = .white

            if #available(iOS 13.0, *) {
                toastMessageImageView.image = UIImage(systemName: "checkmark.circle")
                toastMessageImageView.tintColor = .white
            } else {
                toastMessageImageView.image = UIImage(named: "white-circled-check")
            }
        case .mergeFailure, .noBarcodeFounded, .loadingError:
            toastMessageView.backgroundColor = UIColor(red: 253 / 255.0, green: 157 / 255.0, blue: 45 / 255.0, alpha: 1.0)

            if #available(iOS 13.0, *) {
                toastMessageImageView.image = UIImage(systemName: "info.circle.fill")
                toastMessageImageView.tintColor = .black
            } else {
                toastMessageImageView.image = UIImage(named: "black-circled-info")
            }
        default:
            break
        }
    }

    static var viewController: UIViewController {
        UIStoryboard.instantiateViewController(storyboardName: storyboardName,
                                                                 ofType: BottomToastMessagesViewController.self,
                                                                 isInitial: false,
                                                                 in: Bundle.main.self)
    }
}

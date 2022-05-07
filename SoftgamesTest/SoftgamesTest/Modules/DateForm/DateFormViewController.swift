//
//  DateFormViewController.swift
//  SoftgamesTest
//
//  Created by Erdi on 7.05.2022.
//

import Foundation
import UIKit
import WebKit

final class DateFormViewController: UIViewController {

    private var webView: WKWebView!
    private let viewModel = DateFormViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadHtmlFile()
    }

    private func setupWebView() {
        self.webView = WKWebView(frame: self.view.bounds, configuration: getWebViewConfiguration())
        self.view.addSubview(webView)
    }

    private func loadHtmlFile() {
        if let url = Bundle.main.url(forResource: "form", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }

    private func getWebViewConfiguration() -> WKWebViewConfiguration {
        let userController = WKUserContentController()
        userController.add(self, name: "observer")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        return configuration
    }
}

// MARK: WKScriptMessageHandler

extension DateFormViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let data = message.body as? [String: String] else { return }

        if let date = data["date"] {
            let jScriptCode = "document.getElementById('dateResult').textContent='calculating...';"
            webView.evaluateJavaScript(jScriptCode)

            viewModel.calculateAgeOfCustomer(dateString: date, today: Date()) { [weak self] age in
                let jScriptCode = "document.getElementById('dateResult').textContent='\(age)';"
                self?.webView.evaluateJavaScript(jScriptCode)
            }
        }

        if let firstName = data["name"], let lastName = data["lname"] {
            let result = viewModel.concatenateNames(firstName: firstName, lastName: lastName)
            let jScriptCode = "document.getElementById('nameResult').textContent='\(result)';"
            webView.evaluateJavaScript(jScriptCode)
        }
    }
}

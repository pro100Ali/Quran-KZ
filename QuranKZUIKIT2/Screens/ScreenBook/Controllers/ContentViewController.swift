//
//  ContentViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 03.08.2023.
//

import UIKit
import WebKit

class ContentViewController: UIViewController {

    lazy private var webView: WKWebView = {
       let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.frame = view.bounds
    }
    
    func configure(book: Book) {
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: book.url))
        }
    }
    
}
